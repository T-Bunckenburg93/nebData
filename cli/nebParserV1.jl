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
uniqueShips = sort(unique(allGamesDf.HullKey))

# here we attempt a NN with all ships being pushed to it. 

gdf = groupby(allGamesDf,:GameKey)

shipArray = zeros(24,0)
outcomeArray = fill(true,0)

GameKeyVector = fill(hash(""),0)

for i in gdf

tA = filter(x->x.TeamID == "TeamA",i)
tB = filter(x->x.TeamID == "TeamB",i)


shipArray = hcat(shipArray, vcat(sum(Array(onehotbatch(tA.HullKey, uniqueShips)),dims =2),sum(Array(onehotbatch(tB.HullKey, uniqueShips)),dims =2)))
outcomeArray = push!(outcomeArray,tA.WinningTeam[1] == "TeamA")
push!(GameKeyVector,i.GameKey[1])


# Here we switch up the inputs
shipArray = hcat(shipArray, vcat(sum(Array(onehotbatch(tB.HullKey, uniqueShips)),dims =2),sum(Array(onehotbatch(tA.HullKey, uniqueShips)),dims =2)))
outcomeArray = push!(outcomeArray,tA.WinningTeam[1] == "TeamB")
push!(GameKeyVector,i.GameKey[1])

end

shipArray
outcomeArray
GameKeyVector
# Ok, lets slap this into the NET



# Define our model, a multi-layer perceptron
model = Chain(
    Dense(24 => 64, tanh),   # activation function inside layer
    # Dense(64 => 64, tanh),   # activation function inside layer
    # Dense(64 => 64, tanh),   # activation function inside layer
    # Dense(64 => 64, tanh),   # activation function inside layer
    Dense(64 => 2),
    softmax) |> gpu        # move model to GPU, if available

# The model encapsulates parameters, randomly initialised. Its initial output is:
out1 = model(shipArray |> gpu) |> cpu                                 # 2×1000 Matrix{Float32}

# To train the model, we use batches of 64 samples, and one-hot encoding:
target = Flux.onehotbatch(outcomeArray, [true, false])                   # 2×1000 OneHotMatrix
loader = Flux.DataLoader((shipArray, target) |> gpu, batchsize=32, shuffle=true)
# 16-element DataLoader with first element: (2×64 Matrix{Float32}, 2×64 OneHotMatrix)

optim = Flux.setup(Flux.Adam(0.01), model)  # will store optimiser momentum, etc.

# Training loop, using the whole data set 1000 times:
losses = []
@showprogress for epoch in 1:100
    for (x, y) in loader
        loss, grads = Flux.withgradient(model) do m
            # Evaluate model and loss inside gradient context:
            y_hat = m(x)
            Flux.crossentropy(y_hat, y)
        end
        Flux.update!(optim, model, grads[1])
        push!(losses, loss)  # logging, outside gradient context
    end
end

optim # parameters, momenta and output have all changed
out2 = model(shipArray |> gpu) |> cpu  # first row is prob. of true, second row p(false)

@show mean((out2[1,:] .> 0.5) .== outcomeArray)

plot(losses)

shipArray
model(shipArray |> gpu) |> cpu




allShipNames
allShipNames[18]
allShipNames[1]
allShipNames[end-2]


test = fill(0.0,24)
test[1] = 1
test[end-2] =2

test
model(test |> gpu) |> cpu



function shipfigher(ship1,ship2)

    indexShip1 = findfirst(x-> contains(x,ship1),allShipNames)
    indexShip2 = findlast(x-> contains(x,ship2),allShipNames)
    

xval = []
for i in 0:10

test = fill(0.0,24)
test[indexShip1] = 1
test[indexShip2] =i

x = model(test |> gpu) |> cpu
push!(xval,x[1])


end
p = plot(xval,
        title="1 $ship1 vs n $ship2 ", 
        xlabel = "$ship2 Count",
        ylabel = "probability of $ship1 winning",)

return p 
end

shipfigher(
    "Solomon_Battleship",
    "Shuttle"
)

shipfigher(
    "Axford_Heavy_Cruiser",
    "Tugboat"
)



ANSShips = [
    "Stock/Solomon Battleship"
    "Stock/Axford Heavy Cruiser"
    "Stock/Vauxhall Light Cruiser"
    "Stock/Keystone Destroyer"
    "Stock/Raines Frigate"
    "Stock/Sprinter Corvette"
]
OSPShips = [
    "Stock/Container Hauler"
    "Stock/Bulk Hauler"
    "Stock/Ocello Cruiser"
    "Stock/Bulk Feeder"
    "Stock/Tugboat"
    "Stock/Shuttle"
]



# ok, so now I'll try OSP vs ANS

factionShipArray = zeros(12,0)
factionOutcomeArray = fill(true,0)
GameKeyVectorF = fill(hash(""),0)


test = filter(x->x.faction == "ANS",gdf[3])
sum(Array(onehotbatch(test.HullKey, ANSShips)),dims =2)

test.winningFaction[1] == "ANS"




for i in gdf

    if ("OSP" ∈ i.faction) && ("ANS" ∈ i.faction)

        tOSP = filter(x->x.faction == "OSP",i)
        tANS = filter(x->x.faction == "ANS",i)


        factionShipArray = hcat(factionShipArray, vcat(sum(Array(onehotbatch(tANS.HullKey, ANSShips)),dims =2),sum(Array(onehotbatch(tOSP.HullKey, OSPShips)),dims =2)))
        factionOutcomeArray = push!(factionOutcomeArray,tANS.winningFaction[1] == "ANS")
        push!(GameKeyVectorF,i.GameKey[1])

    end

# Here we switch up the inputs
# shipArray = hcat(shipArray, vcat(sum(Array(onehotbatch(tB.HullKey, uniqueShips)),dims =2),sum(Array(onehotbatch(tA.HullKey, uniqueShips)),dims =2)))
# outcomeArray = push!(outcomeArray,tA.WinningTeam[1] == "TeamB")
# push!(GameKeyVector,i.GameKey[1])

end

factionShipArray
factionOutcomeArray
GameKeyVectorF
# Ok, lets slap this into the NET



# Define our model, a multi-layer perceptron
model = Chain(
    Dense(12 => 24, tanh),   # activation function inside layer
    # Dense(24 => 24, tanh),   # activation function inside layer
    # Dense(64 => 64, tanh),   # activation function inside layer
    # Dense(64 => 64, tanh),   # activation function inside layer
    Dense(24 => 2),
    softmax) |> gpu        # move model to GPU, if available

# The model encapsulates parameters, randomly initialised. Its initial output is:
out1 = model(factionShipArray |> gpu) |> cpu                                 # 2×1000 Matrix{Float32}

# To train the model, we use batches of 64 samples, and one-hot encoding:
target = Flux.onehotbatch(factionOutcomeArray, [true, false])                   # 2×1000 OneHotMatrix
loader = Flux.DataLoader((factionShipArray, target) |> gpu, batchsize=32, shuffle=true)
# 16-element DataLoader with first element: (2×64 Matrix{Float32}, 2×64 OneHotMatrix)

optim = Flux.setup(Flux.Adam(0.01), model)  # will store optimiser momentum, etc.

# Training loop, using the whole data set 1000 times:
losses = []
@showprogress for epoch in 1:65
    for (x, y) in loader
        loss, grads = Flux.withgradient(model) do m
            # Evaluate model and loss inside gradient context:
            y_hat = m(x)
            Flux.crossentropy(y_hat, y)
        end
        Flux.update!(optim, model, grads[1])
        push!(losses, loss)  # logging, outside gradient context
    end
end

optim # parameters, momenta and output have all changed
out2 = model(factionShipArray |> gpu) |> cpu  # first row is prob. of true, second row p(false)

@show mean((out2[1,:] .> 0.5) .== factionOutcomeArray)  

plot(losses)
# Yea Nice. 

allShips = vcat(ANSShips ,OSPShips)













allShipNames = 
vcat(
    string.("teamA_",(replace.(uniqueShips,"Stock/"=> ""," "=> "_"))),
    string.("teamB_",(replace.(uniqueShips,"Stock/"=> ""," "=> "_")))
)


vals = DataFrame(rotr90(shipArray),:auto)

rename!(vals,names(vals) .=> allShipNames)

vals.GameKeyVector = GameKeyVector
vals.TeamAWin = outcomeArray


vals


ols = lm(@formula(TeamAWin ~  
teamA_Axford_Heavy_Cruiser+
teamA_Bulk_Feeder+
teamA_Bulk_Hauler+
teamA_Container_Hauler+
teamA_Keystone_Destroyer+
teamA_Ocello_Cruiser+
teamA_Raines_Frigate+
teamA_Shuttle+
teamA_Solomon_Battleship+
teamA_Sprinter_Corvette+
teamA_Tugboat+
teamA_Vauxhall_Light_Cruiser+
teamB_Axford_Heavy_Cruiser+
teamB_Bulk_Feeder+
teamB_Bulk_Hauler+
teamB_Container_Hauler+
teamB_Keystone_Destroyer+
teamB_Ocello_Cruiser+
teamB_Raines_Frigate+
teamB_Shuttle+
teamB_Solomon_Battleship+
teamB_Sprinter_Corvette+
teamB_Tugboat+
teamB_Vauxhall_Light_Cruiser
), vals)

fieldnames(typeof(ols))

coef(ols)



ols.model 
findmax(abs.(coef(ols))[2:end])


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

