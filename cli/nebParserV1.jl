using Pkg, XML, XMLDict, OrderedCollections, Dates, DataFrames

savePath = "C:/Program Files (x86)/Steam/steamapps/common/Nebulous/Saves/SkirmishReports"
saves = readdir(savePath)

# This gets to the node
filename = joinpath(savePath,saves[1])
doc = read(filename, Node)

# so the goal of this, is to turn a neb battle report into a single row that could be fed into a NN.
# Initally I think a row for each ship. 

# Here is the code that gets us to here:

"""
```
findElement(node::Node,elementName::String)
```

This function seaches the child elements of node, and returns the first one specified

If there is no match, then the child elements are printed
"""
function findElement(node::Node,elementName::String)

    childrenNodeNames = tag.(children(node))

    nodeWeWant = findfirst(x->x==elementName,childrenNodeNames)
    
    if nodeWeWant != nothing
    
        return children(node)[nodeWeWant]
    
    else 
        println("Node: ",elementName, " doesn't exist")
        println("Printing all nodes: ")
        println.("   ",childrenNodeNames)
        return
    end
end
function findElement(node::Node)
    findElement(node,"")
end
# findElement(doc,"FullAfterActionReport")


"""
```
function getElementValue(ShipsNode)
```
assumes that there is a single value under the node, tries to pull it out, else returns ""
"""
function getElementValue(node::Node,element::String)::String
    x = nothing
    try 
        x = value(children(findElement(node,element))[1])
    catch e

    end

    if x == nothing
        return ""
    else
        return x
    end
end



"""
```
ShipBattleReport(ShipBattleReportNode::Node)
```

takes an element of name '<ShipBattleReport>' and returns a single line of a dataframe that contains all the information about the ship
"""
function ShipBattleReport(ShipBattleReportNode)::DataFrame

    # findElement(ShipBattleReport1)

    # these are all the single values that we can pull out at this level. 
    # More complicated stuff comes later
    ShipName = getElementValue(ShipBattleReportNode,"ShipName")
    HullString = getElementValue(ShipBattleReportNode,"HullString")
    HullKey = getElementValue(ShipBattleReportNode,"HullKey")
    Eliminated = getElementValue(ShipBattleReportNode,"Eliminated")
    EliminatedTimestamp = getElementValue(ShipBattleReportNode,"EliminatedTimestamp")
    WasDefanged = getElementValue(ShipBattleReportNode,"WasDefanged")
    DefangedTimestamp = getElementValue(ShipBattleReportNode,"DefangedTimestamp")
    OriginalCrew = getElementValue(ShipBattleReportNode,"OriginalCrew")
    FinalCrew = getElementValue(ShipBattleReportNode,"FinalCrew")
    TotalDamageReceived = getElementValue(ShipBattleReportNode,"TotalDamageReceived")
    TotalDamageRepaired = getElementValue(ShipBattleReportNode,"TotalDamageRepaired")
    TotalDamageDealt = getElementValue(ShipBattleReportNode,"TotalDamageDealt")
    TotalTimeInContact = getElementValue(ShipBattleReportNode,"TotalTimeInContact")
    OriginalPointCost = getElementValue(ShipBattleReportNode,"OriginalPointCost")
    TotalDistanceTravelled = getElementValue(ShipBattleReportNode,"TotalDistanceTravelled")
    AmmoPercentageExpended = getElementValue(ShipBattleReportNode,"AmmoPercentageExpended")
    
    df = DataFrame(
        ShipName = ShipName,
        HullString = HullString,
        HullKey = HullKey,
        Eliminated = Eliminated,
        EliminatedTimestamp = EliminatedTimestamp,
        WasDefanged = WasDefanged,
        DefangedTimestamp = DefangedTimestamp,
        OriginalCrew = OriginalCrew,
        FinalCrew = FinalCrew,
        TotalDamageReceived = TotalDamageReceived,
        TotalDamageRepaired = TotalDamageRepaired,
        TotalDamageDealt = TotalDamageDealt,
        TotalTimeInContact = TotalTimeInContact,
        OriginalPointCost = OriginalPointCost,
        TotalDistanceTravelled = TotalDistanceTravelled,
        AmmoPercentageExpended = AmmoPercentageExpended
    )

    return df
end

"""
```
function getShips(ShipsNode)
```
Takes a ships node and returns a DF of the ships exist under it
"""
function getShips(ShipsNode)

    shipDf = DataFrame()
    for i in children(ShipsNode)
    
        ship = ShipBattleReport(i)
        append!(shipDf,ship;  cols = :union)
    end
    return shipDf

end

"""
```
function getPlayerReport(ShipsNode)
```
Takes a <AARPlayerReportOfShipBattleReport> node and returns a DF of the player report
"""
function getPlayerReport(PlayerNode)

    PlayerID = getElementValue(PlayerNode,"PlayerID")
    PlayerName = getElementValue(PlayerNode,"PlayerName")

    # for each player we want to get the ships
    shipDf = getShips(findElement(PlayerNode,"Ships"))

    shipDf.PlayerName .= PlayerName
    shipDf.PlayerID .= PlayerID

    return shipDf

end

"""
```
function getTeamReport(teamNode)
```
Takes a <TeamReportOfShipBattleReport> node and returns a DF of the team report
"""
function getTeamReport(teamNode)
    TeamID = getElementValue(teamNode,"TeamID")
    Players = findElement(teamNode,"Players")

    teamDF = DataFrame()
    for i in children(Players)
        playerDF = getPlayerReport(i)
        append!(teamDF,playerDF;  cols = :union)
    end
    teamDF.TeamID .= TeamID
    return teamDF
end




"""
```
function matchReport(filename)
```
Takes a this takes a neb XML battle report filepath and  returns a DF
"""
function matchReport(filename)

    doc = read(filename, Node)

    FullAfterActionReport = findElement(doc,"FullAfterActionReport")

    # Get the first cut of the after action report, Note may not need all of these, 
    GameFinished = getElementValue(FullAfterActionReport,"GameFinished")
    GameStartTimestamp = getElementValue(FullAfterActionReport,"GameStartTimestamp")
    GameDuration = getElementValue(FullAfterActionReport,"GameDuration")
    WinningTeam = getElementValue(FullAfterActionReport,"WinningTeam")
    Multiplayer = getElementValue(FullAfterActionReport,"Multiplayer")
    Time = getElementValue(FullAfterActionReport,"Time")
    # Subsequent nodes:
    LobbyId = findElement(FullAfterActionReport,"LobbyId")
    Teams = findElement(FullAfterActionReport,"Teams")

    # there are generally 2 teams:



    ReportDF = DataFrame()
    for i in children(Teams)
        teamReport = getTeamReport(i)
        append!(ReportDF,teamReport;  cols = :union)
    end


    ReportDF.GameStartTimestamp .= GameStartTimestamp
    ReportDF.GameDuration .= GameDuration
    ReportDF.WinningTeam .= WinningTeam
    ReportDF.Multiplayer .= GameStartTimestamp
    ReportDF.Multiplayer .= Multiplayer
    ReportDF.Time .= Time
    return ReportDF

end
# matchReport(joinpath(savePath,saves[3]))


saves = readdir(savePath)

allGamesDf = DataFrame()

for i in saves
    df = matchReport(joinpath(savePath,i))
    append!(allGamesDf,df;  cols = :union)

end


allGamesDf




# here is some old code that still might be useful
# function getParts(parts)

#     partdf = DataFrame(
#         partKey = String[],
#         partHealthPct = Float64[],
#         partDestroyed = String[]
        
#         )

#     for P in children(parts)

#         key =     
#             simplevalue(
#                 children(
#                     P
#                 )[1]
#             )
#         health =     
#             parse(Float64,
#                 simplevalue(
#                     children(
#                         P
#                     )[2]
#                 )
#             )
#         destroyed =     
#             simplevalue(
#                 children(
#                     P
#                 )[3]
#             )

#         push!(partdf, (key, health,destroyed))
        
#     end    
#     return partdf
# end
# # parts = 
# #     children(
# #         ships[1]
# #     )[13]
# # df = getParts(parts)


# df = getParts(parts)




# function parseShip(ship)

#     # Get high level ship vals
#     ShipName = 
#         simplevalue(
#             children(
#                 ship
#             )[1]
#         )
#     HullString = 
#         simplevalue(
#             children(
#                 ship
#             )[2]
#         )
#     HullKey = 
#         simplevalue(
#             children(
#                 ship
#             )[3]
#         )
#     Eliminated = 
#         simplevalue(
#         children(
#             ship
#         )[4]
#         )
#     EliminatedTimestamp = 
#         simplevalue(
#         children(
#             ship
#         )[5]
#         )
#     WasDefanged = 
#         simplevalue(
#         children(
#             ship
#         )[6]
#         )
#     DefangedTimestamp = 
#         simplevalue(
#         children(
#             ship
#         )[7]
#         )
#     OriginalCrew  =      
#         simplevalue(
#         children(
#             ship
#         )[8]
#         )
#     FinalCrew =
#         simplevalue(
#         children(
#             ship
#         )[9]
#         )            
#     TotalDamageReceived =        
#         simplevalue(
#         children(
#             ship
#         )[10]
#         )
#     TotalDamageRepaired =      
#         simplevalue(
#         children(
#             ship
#         )[11]
#         )
#     TotalDamageDealt =  
#         simplevalue(
#         children(
#             ship
#         )[12]
#         )

#     parts = 
#         (
#         children(
#             ship
#         )[13]
#         )
    
#     partsdf = getParts(parts)

#     # make part paired with hull
#     partsdf.partName .= string.(HullKey," - PartHealth - ",partsdf.partKey)
#     partsdfWide = unstack(select(partsdf,[:partName, :partHealthPct]) ,:partName, :partHealthPct )

#     Condition =  
#         simplevalue(
#         children(
#             ship
#         )[14]
#         )   
#     TotalTimeInContact =  
#         simplevalue(
#         children(
#             ship
#         )[15]
#         ) 
#     OriginalPointCost =  
#         simplevalue(
#         children(
#             ship
#         )[16]
#         )   
#     TotalDistanceTravelled =  
#         simplevalue(
#         children(
#             ship
#         )[17]
#         )   
#     AmmoPercentageExpended =  
#         simplevalue(
#         children(
#             ship
#         )[18]
#         )  

# # lets look at the engagement history

#     eng =  
#         children(
#             ship
#         )[19]

#     engagements = []
#     for i in children(eng)
#         ShipName = simplevalue(children(i)[1])
#         EndingStatus = simplevalue(children(i)[3])
#         push!(engagements,(ShipName,EndingStatus))
#     end
#     # engagements

#     AntiShipEfficiency = 
#     parse(Float64,
#         something(
#             value(
#                 children(
#                     children(ships)[20]
#                 )[1]
#             ),"0 ")
#     )

#     # And the weapon reports:

#     wepReports = 
#         children(
#         children(
#             children(ships)[20]
#         )[3]
#         )

# # ok so init the first WR df
#         WeaponReportDf = DataFrame(
#                 WeaponName = String[],
#                 # GroupName = String[],
#                 # WeaponKey = String[],
#                 MaxDamagePerShot = Float64[],
#                 TotalDamageDone = Float64[],
#                 TargetsAssigned = Float64[],
#                 TargetsDestroyed = Float64[],
#                 RoundsCarried = Float64[],
#                 ShotsFired = Float64[],
#                 HitCount = Float64[],
#                 )

#         for i in wepReports

#             WeaponName = simplevalue(children(i)[1])
#             GroupName = simplevalue(children(i)[2])
#             WeaponKey = simplevalue(children(i)[3])
#             MaxDamagePerShot = parse(Float64,simplevalue(children(i)[4]))
#             TotalDamageDone = parse(Float64,simplevalue(children(i)[5]))
#             TargetsAssigned = parse(Float64,simplevalue(children(i)[6]))
#             TargetsDestroyed = parse(Float64,simplevalue(children(i)[7]))
#             RoundsCarried = parse(Float64,something(value(children(i)[8]), "0"))
#             ShotsFired = parse(Float64,simplevalue(children(i)[9]))
#             HitCount = parse(Float64,simplevalue(children(i)[10]))

#             push!(WeaponReportDf,(
#                 WeaponName,
#                 # GroupName,
#                 # WeaponKey,
#                 MaxDamagePerShot,
#                 TotalDamageDone,
#                 TargetsAssigned,
#                 TargetsDestroyed,
#                 RoundsCarried,
#                 ShotsFired,
#                 HitCount,       
                
#                 )
#             )

#         end
#         # WeaponReportDf

#         # Now we need to turn this into a single row
#         WeaponReportFinal = DataFrame()

#         for i in eachrow(WeaponReportDf)

#             wepName = i.WeaponName
#             oldNames = names(i[2:end])
#             newnames = string.(wepName,oldNames)

#             df = DataFrame(i[2:end])

#             rename!(df,oldNames .=> newnames)

#             DataFrames.hcat!(WeaponReportFinal,df)

#         end
#         # WeaponReportFinal



#         # And missile report
#         MissileEfficiency =
#         parse(Float64,
#             simplevalue((
#                 children(
#                     children(ships)[21]
#                 )[1]
#                 ))
#             )


#     missileReport = 
#         children(
#         children(
#             children(ships)[21]
#         )[3]
#         )

#     if size(missileReport,1) == 0 
#         MissileReportFinal = DataFrame()
#     else


#         children(missileReport[1])

# # ok so init the first WR df
#         missReportDf = DataFrame(
#                 MissileDesc = String[],
#                 MissileKey = String[],
#                 TotalCarried = Float64[],
#                 TotalExpended = Float64[],
#                 TotalDamageDone = Float64[],
#                 # IndividualDamagePotential = Float64[],
#                 Hits = Float64[],
#                 Misses = Float64[],
#                 Softkills = Float64[],
#                 Hardkills = Float64[],
#                 )

#         for i in missileReport

#             # MissileName = simplevalue(children(i)[1])
#             MissileDesc = simplevalue(children(i)[2])


#             MissileKey = simplevalue(children(i)[3])
#             TotalCarried = parse(Float64,simplevalue(children(i)[4]))
#             TotalExpended = parse(Float64,simplevalue(children(i)[5]))
#             # IndividualDamagePotential = parse(Float64,simplevalue(children(i)[6]))
#             TotalDamageDone = parse(Float64,simplevalue(children(i)[7]))
#             Hits = parse(Float64,simplevalue(children(i)[8]))
#             Misses = parse(Float64,simplevalue(children(i)[9]))
#             Softkills = parse(Float64,simplevalue(children(i)[10]))
#             Hardkills = parse(Float64,simplevalue(children(i)[11]))

#             push!(missReportDf,(
#                 MissileDesc,
#                 MissileKey,
#                 TotalCarried,
#                 TotalExpended,
#                 TotalDamageDone,
#                 Hits,
#                 Misses,
#                 Softkills,
#                 Hardkills,   
                
#                 )
#             )

#         end
#         nm = names(missReportDf)[3:end]
#         missReportDf.missileDescKey = string.(missReportDf.MissileKey," - ", missReportDf.MissileDesc)
        
#         # We need to agg it incase there are several similar missiles
#         missReportAgg = combine(groupby(missReportDf,:missileDescKey),Symbol.(nm) .=> sum .=> Symbol.(nm) )

#         # Now we need to turn this into a single row
#         MissileReportFinal = DataFrame()

#         for i in eachrow(missReportAgg)

#             wepName = i.missileDescKey
#             oldNames = names(i[2:end])
#             newnames = string.(wepName,oldNames)

#             df = DataFrame(i[2:end])

#             rename!(df,oldNames .=> newnames)

#             DataFrames.hcat!(MissileReportFinal,df)

#         end
#         MissileReportFinal
#     end



# # ok, lets get this into a DF

# shipLine = DataFrame(
#     ShipName = ShipName,
#     HullString = HullString,
#     HullKey = HullKey,
#     Eliminated = Eliminated,
#     EliminatedTimestamp = EliminatedTimestamp,
#     WasDefanged = WasDefanged,
#     DefangedTimestamp = DefangedTimestamp,
#     OriginalCrew = OriginalCrew,
#     FinalCrew = FinalCrew,
#     TotalDamageReceived = TotalDamageReceived,
#     TotalDamageRepaired= TotalDamageRepaired,
#     TotalDamageDealt = TotalDamageDealt,
#     Condition = Condition,
#     TotalTimeInContact = TotalTimeInContact,
#     OriginalPointCost = OriginalPointCost,
#     TotalDistanceTravelled = TotalDistanceTravelled,
#     AmmoPercentageExpended = AmmoPercentageExpended,
#     AntiShipEfficiency = AntiShipEfficiency,
#     MissileEfficiency = MissileEfficiency,
#     Engagements = [engagements],
# )


# hcat(shipLine,partsdfWide,WeaponReportFinal,MissileReportFinal)



# end
# player = 
# children(
#     children(
#         children(
#             children(
#                 children(
#                     doc[2]  
#                 )[8] ## gets to the teams
#             )[1] ## Gets team A or B
#         )[2] ## player name field
#     )[2] ## actually selects player name
# ) ## Gets to the ships

# ships = 
#     children(
#     player[end]
#     )[1]

# parseShip(ships)

