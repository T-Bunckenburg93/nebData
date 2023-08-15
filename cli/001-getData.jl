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


matchReport(savesKillboard[1])


allGamesDf = DataFrame()

for i in allSaves
    try
        df = matchReport(i)
        append!(allGamesDf,df;  cols = :union)
    catch e
        println(i)
    end

end

allGamesDf
disallowmissing!(allGamesDf)

filter(x->x.Multiplayer == "true",allGamesDf)
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




allGamesDf.GameKey .= hash("")

for i in eachrow(allGamesDf)
    i.GameKey = hash(string(i.Time,i.GameStartTimestamp,i.GameDuration,i.WinningTeam,i.Multiplayer))
end

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
jldsave("BattleReports/allGameData.jld2";df = allGamesDf)

allGamesDf = load_object("BattleReports/allGameData.jld2")


