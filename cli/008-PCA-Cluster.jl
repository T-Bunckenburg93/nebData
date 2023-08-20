
using XML, Dates, DataFrames, StatsBase, JLD2, Clustering , MultivariateStats, OneHotArrays


allGamesDf = load_object("BattleReports/allGameDataComponents.jld2")

# game Player ship are probably the keys 


IDs = select(allGamesDf,[:GameKey,:PlayerName,:PlayerID,:HullKey,:HullString,:ShipName])


z = names(allGamesDf)

println.(z)

keys = text_values = [
    "ShipName",
    "HullString",
    "HullKey",
    "Eliminated",
    "EliminatedTimestamp",
    "WasDefanged",
    "DefangedTimestamp",
    "OriginalCrew",
    "FinalCrew",
    "TotalDamageReceived",
    "TotalDamageRepaired",
    "TotalDamageDealt",
    "TotalTimeInContact",
    "OriginalPointCost",
    "TotalDistanceTravelled",
    "AmmoPercentageExpended",
    "PlayerName",
    "PlayerID",
    "TeamID",
    "GameStartTimestamp",
    "GameDuration",
    "WinningTeam",
    "Multiplayer",
    "Time",
    "GameKey",
    "matchSavePath",
    "faction",
    "winningFaction"
]

weaponVals = filter(x-> x ∉ keys, names(allGamesDf) )

weps = first.(split.(weaponVals,"::"))
varType = last.(split.(weaponVals,"::"))
unique(weps)
unique(varType)

WeaponVals = filter(x-> contains(x,"RoundsCarried") || contains(x,"TotalCarried") ,weaponVals )
eWar = sort(filter(x-> !contains(x,"Stock/") && contains(x,"ShotDuration") ,weaponVals ))


ewarDf = DataFrame(replace(Matrix(select(allGamesDf,eWar)),missing => 0.0),eWar)
weapondf = DataFrame(replace(Matrix(select(allGamesDf,WeaponVals)),missing => 0.0),WeaponVals)

hulls = sort(unique(allGamesDf.HullKey))

hullDf = DataFrame(Float64.(rotl90(onehotbatch(allGamesDf.HullKey, hulls))),hulls)

pointCost = parse.(Float64,allGamesDf.OriginalPointCost)

win= (allGamesDf.faction .== allGamesDf.winningFaction)

table2Cluster = hcat(hullDf,weapondf,ewarDf)
table2Cluster.pointCost = pointCost


table2Cluster

