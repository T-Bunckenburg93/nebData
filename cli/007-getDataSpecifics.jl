using Pkg, XML, XMLDict, OrderedCollections, Dates, DataFrames, Flux, CUDA, OneHotArrays, StatsBase, ProgressMeter, Plots, GLM, JLD2 
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
function getElementValue(node::Node,nothing)::String
return ""
end

"""
```
SubReport(Weapons::Node)
```

takes an element that may have at least 1 
children underneath  it. These children
elements are turned into a dataframe, which is returned
"""
function SubReport(element)

outDf = DataFrame()
    # check if node is empty 
    if children(element) != Node[]
        for v in children(element)

            vals = tag.(children(v))
            sz = size(vals,1)

            x= fill("",sz)
            for i in 1:sz
                j = getElementValue(v,vals[i])
                if !isnothing(j)
                    x[i] = j
                end
            end

            append!(outDf, 
                    permutedims(DataFrame(Name1 = string.(vals), Value1 = x),1)[!,2:end],
                    cols= :union
            )
        end
    end
    return outDf
end


"""
Takes a df from ideally the sub report and flattens it to a single row. 

the name of the component is added to the col. 
"""
function flattenSubReport(dfIn::DataFrame,dfkey::Symbol,dfNot::Vector{Symbol})::DataFrame
    # check null df
    dfOut = DataFrame()
    if dfIn != DataFrame()
        # stack all the types and vars
        dfLong = stack(select(dfIn,Not(dfNot)),names(dfIn,Not(vcat(dfkey,dfNot))))

        replace!(dfLong.value, "" => "0")
        replace!(dfLong.value, missing => "0")
        
        filter!(x->x.value ∉ [ "true" "false" ""],dfLong)
        filter!(x->!ismissing(x.value) ,dfLong)


        dfLong.value = parse.(Float64, dfLong.value)
        # combine types and vars
        dfLong[!,:variable] = string.(dfLong[!,dfkey],"::",dfLong[!,:variable])

        # and unstack so we have type::var collums, with the value under
        dfOut = unstack(select(dfLong,Not(dfkey)),:variable,:value)
    end
    return dfOut
end
function flattenSubReport(dfIn::DataFrame,dfkey::Symbol)::DataFrame
    # check null df
    dfOut = DataFrame()
    if dfIn != DataFrame()
        # stack all the types and vars
        dfLong = stack(dfIn,names(dfIn,Not(dfkey)))

        replace!(dfLong.value, "" => "0")
        replace!(dfLong.value, missing => 0.0)
        
        filter!(x->x.value ∉ [ "true" "false" ""],dfLong)
        filter!(x->!ismissing(x.value) ,dfLong)


        # dfLong.value = parse.(Float64, dfLong.value)
        # combine types and vars
        dfLong[!,:variable] = string.(dfLong[!,dfkey],"::",dfLong[!,:variable])

        # and unstack so we have type::var collums, with the value under
        dfOut = unstack(select(dfLong,Not(dfkey)),:variable,:value)
    end
    return dfOut
end


# flattenSubReport(WeaponsDf,:GroupName,[:Name,:WeaponKey])
# flattenSubReport(MissilesDf,:MissileKey,[:MissileName,:MissileDesc])
# flattenSubReport(EWWeaponsDf,:WeaponKey,[:GroupName,:Name])


function pullOutSubReport(node::Node,key,col2Keep)

    nodeDf = SubReport(node)
    if nodeDf != DataFrame()

        for i in col2Keep

            nodeDf[!,i] = tryparse.(Float64,nodeDf[!,i])

        end

        nodeDf

        nodeDf2 = combine(groupby(nodeDf,key),col2Keep .=> sum .=>col2Keep)
        return flattenSubReport(nodeDf2,key)
    else return DataFrame()
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

    AntiShip = findElement(ShipBattleReportNode,"AntiShip")
    Strike = findElement(ShipBattleReportNode,"Strike")
    Sensors = findElement(ShipBattleReportNode,"Sensors")
    Defenses = findElement(ShipBattleReportNode,"Defenses")

    Weapons = findElement(AntiShip,"Weapons")
    Missiles = findElement(Strike,"Missiles")
    EWWeapons = findElement(Sensors,"EWWeapons")

    WeaponsDf = pullOutSubReport(Weapons,:GroupName,[:TotalDamageDone,:TargetsAssigned,:TargetsDestroyed,:RoundsCarried,:ShotsFired,:HitCount])
    MissilesDf = pullOutSubReport(Missiles,:MissileKey,[:TotalCarried,:TotalExpended,:TotalDamageDone,:Hits,:Misses,:Softkills,:Hardkills])
    EWWeaponsDf = pullOutSubReport(EWWeapons,:Name,[:TargetsAssigned,:ShotDuration])

    # This is the PD. WIP
    PDdf = DataFrame()
    PointDefenceDF = DataFrame()
    if !isnothing(Defenses)   
        PointDefence = findElement(Defenses,"WeaponReports")

        for i in 1:size(children(PointDefence),1)

            # this code is gross but seems to work
            Pdata = select(SubReport((PointDefence[i])),["Name","RoundsCarried"])
            filter!(x -> any(!ismissing, x), Pdata)
            Pdata.WeaponCount .= getElementValue(PointDefence[i],"WeaponCount")

            # now we need to make this long
            # we're effectively just looking at PD for this.
            filter!(x-> !contains(x.Name,"HE-RPF"),Pdata)

            append!(PDdf,Pdata, cols = :union)
        end
        PDdfLong = stack(PDdf,["RoundsCarried","WeaponCount"])
        PDdfLong[!,:variable] = string.(PDdfLong[!,"Name"],"::",PDdfLong[!,:variable])
        PointDefenceDF = unstack(select(PDdfLong,Not("Name")),:variable,:value)
    end
    
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
        AmmoPercentageExpended = AmmoPercentageExpended,
    )

    dfOut =    hcat(df,
                    WeaponsDf,
                    MissilesDf,
                    EWWeaponsDf,
                    PointDefenceDF,
                    )

    return dfOut
end


# AAtest = matchReport(savesKillboard[3])


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

    if size(readlines(filename),1) == 2
        # parse(Node, str)
        doc = parse(Node,readlines(filename)[2])

    elseif size(readlines(filename),1) > 1

        doc = read(filename, Node)

    end

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

    # and give the match a unique key
    gameHash = hash(Matrix(ReportDF))

    ReportDF.GameKey .= gameHash

    return ReportDF

end
# matchReport(joinpath(savePath,saves[3]))

localPath = "BattleReports"

savesLocal = joinpath.(savePath,readdir(savePath))
savesKillboard = joinpath.(localPath,readdir(localPath))

allSaves = vcat(
    savesLocal,
    savesKillboard,
)


yes= matchReport(savesKillboard[5])




allGamesDf = DataFrame()

for i in allSaves
    try
        df = matchReport(i)
        df.matchSavePath .= i
        append!(allGamesDf,df;  cols = :union)
    catch e
        println(i)
    end

end
allGamesDf
names(allGamesDf)


# typeof(allGamesDf[!,40])

# for eachcol in 

# mapcols(col -> replace(col, missing => 0), allGamesDf)

# disallowmissing!(allGamesDf)

filter!(x->x.Multiplayer == "true",allGamesDf)
factions = ["ANS" "OSP"]
a = "OSP"
filter(x->x != a,factions)[1]


# get the OSP vs ANS teams

allGamesDf.faction .= ""
allGamesDf.winningFaction .= ""

names(allGamesDf)

for r in eachrow(allGamesDf)
    if r.HullKey ∈     
                    [
                    "Stock/Axford Heavy Cruiser"
                    # "Stock/Bulk Feeder"
                    # "Stock/Bulk Hauler"
                    # "Stock/Container Hauler"
                    "Stock/Keystone Destroyer"
                    # "Stock/Ocello Cruiser"
                    "Stock/Raines Frigate"
                    # "Stock/Shuttle"
                    "Stock/Solomon Battleship"
                    "Stock/Sprinter Corvette"
                    # "Stock/Tugboat"
                    "Stock/Vauxhall Light Cruiser"
                    ]
                    r.faction = "ANS"
                        
    elseif r.HullKey ∈    
                    [
                    # "Stock/Axford Heavy Cruiser"
                    "Stock/Bulk Feeder"
                    "Stock/Bulk Hauler"
                    "Stock/Container Hauler"
                    # "Stock/Keystone Destroyer"
                    "Stock/Ocello Cruiser"
                    # "Stock/Raines Frigate"
                    "Stock/Shuttle"
                    # "Stock/Solomon Battleship"
                    "Stock/Sprinter Corvette"
                    "Stock/Tugboat"
                    # "Stock/Vauxhall Light Cruiser"
                    ]
                    r.faction = "OSP"
    end
    if r.TeamID == r.WinningTeam 
        r.winningFaction = r.faction
    else 
        r.winningFaction = filter(x->x != r.faction,factions)[1]
    end
end




# allGamesDf.GameKey .= hash("")

# for i in eachrow(allGamesDf)
#     i.GameKey = hash(string(i.Time,i.GameStartTimestamp,i.GameDuration,i.WinningTeam,i.Multiplayer))
# end

coreShips = [
    "Stock/Axford Heavy Cruiser"
    "Stock/Bulk Feeder"
    "Stock/Bulk Hauler"
    "Stock/Container Hauler"
    "Stock/Keystone Destroyer"
    "Stock/Ocello Cruiser"
    "Stock/Raines Frigate"
    "Stock/Shuttle"
    "Stock/Solomon Battleship"
    "Stock/Sprinter Corvette"
    "Stock/Tugboat"
    "Stock/Vauxhall Light Cruiser"
]

# Get base ships only
filter!(x->x.HullKey ∈  coreShips, allGamesDf)

allGamesDf

# save this as a julia object into battle reports
jldsave("BattleReports/allGameDataComponents.jld2";df = allGamesDf)

allGamesDf = load_object("BattleReports/allGameDataComponents.jld2")

names(allGamesDf)

#scratch











doc = parse(Node,readlines(savesKillboard[1])[2])


AAAAATEST = matchReport(savesKillboard[2])

FullAfterActionReport = findElement(doc,"FullAfterActionReport")
Teams = findElement(FullAfterActionReport,"Teams")
TeamReportOfShipBattleReport = findElement(Teams,"TeamReportOfShipBattleReport")
Players = findElement(TeamReportOfShipBattleReport,"Players")
AARPlayerReportOfShipBattleReport = findElement(Players,"AARPlayerReportOfShipBattleReport")
AARPlayerReportOfShipBattleReport = Players[2]

Ships = findElement(AARPlayerReportOfShipBattleReport,"Ships")
ShipBattleReport(Ships[2])


ShipBattleReport2 = Ships[2]


AntiShip = findElement(ShipBattleReport2,"AntiShip")
Strike = findElement(ShipBattleReport2,"Strike")
Sensors = findElement(ShipBattleReport2,"Sensors")
Defenses = findElement(ShipBattleReport2,"Defenses")
PDreports = findElement(Defenses,"WeaponReports")




df = DataFrame()
for i in 1:size(children(PDreports),1)

    # this code is gross but seems to work
    data = select(SubReport((PDreports[i])),["Name","RoundsCarried"])
    filter!(x -> any(!ismissing, x), data)
    data.WeaponCount .= getElementValue(PDreports[i],"WeaponCount")

    # now we need to make this long
    # we're effectively just looking at PD for this.
    filter!(x-> !contains(x.Name,"HE-RPF"),data)

    

    append!(df,data, cols = :union)
end
df

dfLong = stack(df,["RoundsCarried","WeaponCount"])
dfLong[!,:variable] = string.(dfLong[!,"Name"],"::",dfLong[!,:variable])
dfOut = unstack(select(dfLong,Not("Name")),:variable,:value)


# dfLong = stack(dfIn,names(dfIn,Not(dfkey)))

# replace!(dfLong.value, "" => "0")
# replace!(dfLong.value, missing => 0.0)

# filter!(x->x.value ∉ [ "true" "false" ""],dfLong)
# filter!(x->!ismissing(x.value) ,dfLong)


# # dfLong.value = parse.(Float64, dfLong.value)
# # combine types and vars
# dfLong[!,:variable] = string.(dfLong[!,dfkey],"::",dfLong[!,:variable])

# # and unstack so we have type::var collums, with the value under
# dfOut = unstack(select(dfLong,Not(dfkey)),:variable,:value)






size(PDreports,1)

children(PDreports)[1]

findElement(PDreports[1],"Weapon")
SubReport(findElement(PDreports[1],"Weapon"))
children(findElement(PDreports[1],"Weapon"))
names(df)

# pullOutSubReport(i,:WeaponKey,[:TargetsAssigned,:ShotDuration])

findElement(PDreports[1],"WeaponCount")

getElementValue(PDreports[1],"WeaponCount")






# Engineering = findElement(ShipBattleReport2,"Engineering")

Weapons = findElement(AntiShip,"Weapons")
Missiles = findElement(Strike,"Missiles")
EWWeapons = findElement(Sensors,"EWWeapons")

Missiles

SubReport(findElement(Defenses,"WeaponReports")[1])
findElement(Defenses,"MissileReports")
findElement(Defenses,"DecoyReports")


WeaponsDf = SubReport(Weapons)
MissilesDf = SubReport(Missiles)
EWWeaponsDf = SubReport(EWWeapons)

names(EWWeaponsDf)


pullOutSubReport(Missiles,:MissileKey,[:TotalCarried,:TotalExpended,:TotalDamageDone,:Hits,:Misses,:Softkills,:Hardkills])
pullOutSubReport(Weapons,:WeaponKey,[:TotalDamageDone,:TargetsAssigned,:TargetsDestroyed,:RoundsCarried,:ShotsFired,:HitCount])
pullOutSubReport(EWWeapons,:Name,[:TargetsAssigned,:ShotDuration])



