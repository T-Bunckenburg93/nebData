using XML, Dates, DataFrames, StatsBase, JLD2, Clustering , MultivariateStats, OneHotArrays,Distances,CSV

HullInfo = CSV.read("data/hull_info.csv",DataFrame,stringtype=String)

allGamesDf = load_object("BattleReports/allGameDataComponents.jld2")

leftjoin!(allGamesDf,HullInfo, on = :HullKey => :Class)


replace!(allGamesDf[!,"Stock/Mk610 Beam Turret::RoundsCarried"],nothing=>1000.0)

replace!(allGamesDf[!,"Stock/Mk600 Beam Cannon::RoundsCarried"],nothing=>1000.0)


t = allGamesDf[!,"Stock/Mk610 Beam Turret::RoundsCarried"]
t = allGamesDf[!,"Stock/Mk600 Beam Cannon::RoundsCarried"]



# game Player ship are probably the keys 


IDs = select(allGamesDf,[:GameKey,:PlayerName,:PlayerID,:HullKey,:HullString,:ShipName])

keys =  [
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
    "winningFaction",
    "Type",
    "Mass",
    "Max Speed",
    "Max Turn Speed",  
    "Armor Thickness",
    "Hull Modifiers",

]

weaponVals = filter(x-> x ∉ keys, names(allGamesDf) )

weps = first.(split.(weaponVals,"::"))
varType = last.(split.(weaponVals,"::"))
unique(weps)
unique(varType)

WeaponVals = filter(x-> contains(x,"RoundsCarried") || contains(x,"TotalCarried") ,weaponVals )
eWar = sort(filter(x-> !contains(x,"Stock/") && contains(x,"ShotDuration") ,weaponVals ))

hullDf = select(allGamesDf,["Point Cost","Structural Integrity"])

ewarDf = DataFrame(replace(Matrix(select(allGamesDf,eWar)),missing => 0.0),eWar)

weapondf = DataFrame(replace(Matrix(select(allGamesDf,WeaponVals)),missing => 0.0, nothing => 0.0),WeaponVals)

# hulls = sort(unique(allGamesDf.HullKey))

# hullDf = DataFrame(Float64.(rotl90(onehotbatch(allGamesDf.HullKey, hulls))),hulls)


# hullDf[!,"Stock/Axford Heavy Cruiser"] = hullDf[!,"Stock/Axford Heavy Cruiser"] .* 1

# table2Cluster = hcat(hullDf,weapondf,ewarDf)


win= (allGamesDf.faction .== allGamesDf.winningFaction)

table2Cluster = hcat(weapondf,ewarDf)


# So I think, for jammers, the shot duration is how many jammers there are. of up to 5
# function oneOrZero(x)
#     if !iszero(x) 
#         return 1 
#     else return 0
#     end
# end
function jammerMod(x)
    if !iszero(x) && (x <= 1)
        return x*5000
    else return x
    end
end
table2Cluster = DataFrame(jammerMod.(Matrix(table2Cluster)),names(table2Cluster))

colNum = 39
names(table2Cluster[!,colNum:colNum])
countmap(table2Cluster[!,colNum])

indz = findall(x-> x == 0.1,table2Cluster[!,colNum])

# AAtest = filter(x->x.PlayerName == "Ruthless Aids",  allGamesDf[indz,:])
AAtest = allGamesDf[indz,:]

(allGamesDf.PlayerName)

table2Cluster = hcat(table2Cluster,hullDf)
table2Cluster.OriginalPointCost = parse.(Float64,allGamesDf.OriginalPointCost)
# table2Cluster.OriginalCrew = parse.(Float64,allGamesDf.OriginalCrew)


# filter!(x->x.OriginalPointCost <= 3000,table2Cluster)

maximum(pointCost)
disallowmissing!(table2Cluster)
# hullAtrribs = Matrix(table2Cluster)
@show describe(table2Cluster);

table2Cluster



dt = fit(UnitRangeTransform,replace(Matrix(table2Cluster), NaN=>0.0); dims=1, unit=true)

hullAtrribs = Matrix(table2Cluster)
hullAtrribs  = StatsBase.transform(dt, Matrix(table2Cluster))


# R = Distances.pairwise(Euclidean(), hullAtrribs,2)
# r = pairwise(Euclidean() , hullAtrribs', dims = 2 )
# replace(Matrix(table2Cluster), NaN=>0.0)
# M = fit(PCA,hullAtrribs';)

# mean(r)
# std(r)

sz = size(hullAtrribs,2)

# norm
# mean(norm.(eachrow(hullAtrribs)))
# minimum(norm.(eachrow(hullAtrribs)))
# std(norm.(eachrow(hullAtrribs)))

clustering = dbscan(rotl90(hullAtrribs), 0.2, min_neighbors = 2, min_cluster_size =2*sz)
clustering.clusters

filter(x->x==0,clustering.assignments)

clustering.assignments
clustering.counts

c1 = clustering.clusters[3]

function EachCluster(c1)

    # get the vals of this cluster
    inds = vcat(c1.core_indices,c1.boundary_indices)
    look = allGamesDf[inds,:]

    look.miss .= true

    missCols = []
    incCols = []

    for i in 1:size(eachcol(look),1)
        if ismissing.(eachcol(look)[i]) == look.miss
            push!(missCols,i)
        else push!(incCols,i)
        end
    end
    missCols
    incCols

    elements = first.(split.(filter(x-> x ∈ vcat(WeaponVals,eWar), names(look)[incCols]),"::"))
    Hulls = countmap(allGamesDf[inds,:].HullKey)
        totalPtCost = parse.(Float64,look[!,"OriginalPointCost"])
    meanCost = mean(totalPtCost)
    stdDevCost = std(totalPtCost)
    clusterSz = size(totalPtCost,1)

    return (Hulls,elements,meanCost,stdDevCost,clusterSz)
end



clustering.clusters
cl = []

for i in clustering.clusters

        push!(cl,EachCluster(i))
end

cl[1]

