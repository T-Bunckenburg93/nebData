using Dates, DataFrames, OneHotArrays, StatsBase, Plots, JLD2, Clustering, CSV, Distances,ProgressMeter,MultivariateStats, LinearAlgebra

# jldsave("AllReports.jld2";df = AllReports)
HullInfo = CSV.read("data/hull_info.csv",DataFrame,stringtype=String)
AllReports = load_object("AllReports.jld2")

AllMatchReports =   deepcopy(AllReports[1])
AllTeamReports =    deepcopy(AllReports[2])
AllShipReports =    deepcopy(AllReports[3])
AllPartReports =    deepcopy(AllReports[4])
AllEngagementReports = deepcopy(AllReports[5])
AllWeaponReports =  deepcopy(AllReports[6])
AllMissileReports = deepcopy(AllReports[7])
AllEwarReports =    deepcopy(AllReports[8])
AllSensorsReport =  deepcopy(AllReports[9])
AllPdReports =      deepcopy(AllReports[10])
AllAmmReports =     deepcopy(AllReports[11])
AllDecoyReports =   deepcopy(AllReports[12])
AllEngineeringReports = deepcopy(AllReports[13])


x = DataFrame(x = 1)
push!(x,["a"],promote = true)

AllPdReports
names(AllShipReports)

ships = select(AllShipReports,[
    "shipKey",
    "HullKey",
    # "TotalDamageDealt",
    # "TotalDamageReceived",
    "OriginalPointCost",
])

# filter!(x->x.HullKey == "Stock/Raines Frigate" , ships)

AllWeaponReports
# For beam weapons, make the ammo 1
replace!(AllWeaponReports.RoundsCarried, nothing => 1)

findfirst.('-',AllWeaponReports.GroupName)

AllWeaponReports.GroupName = first.(split.(AllWeaponReports.GroupName,"-"))

AllWeaponReports.GroupName = string.("WEAP-",AllWeaponReports.GroupName)
Weapons = combine(groupby( AllWeaponReports, [:shipKey,:GroupName]), :RoundsCarried => sum)
WeaponsFlat = unstack(Weapons,1,2,3,fill=0)
names(WeaponsFlat)


AllMissileReports
AllMissileReports.MissileKey = string.("MIS-",AllMissileReports.MissileKey)
missilesCarried = combine(groupby( AllMissileReports, [:shipKey,:MissileKey]), :TotalCarried => sum)
missilesCarriedFlat = unstack(missilesCarried,1,2,3,fill=0)
names(missilesCarriedFlat)

AllEwarReports
AllEwarReports.GroupName = string.("EWAR-",AllEwarReports.GroupName)
ewar = combine(groupby( AllEwarReports, [:shipKey,:GroupName]),  nrow)
ewwarFlat = unstack(ewar,1,2,3,fill=0)

AllPdReports
AllPdReports.WeaponKey = string.("PD-",AllPdReports.WeaponKey)
Pd = combine(groupby( AllPdReports, [:shipKey,:WeaponKey]),  :WeaponCount=>sum)
PdFlat = unstack(Pd,1,2,3,fill=0)

AllAmmReports
AllAmmReports.MissileKey = string.("AMM-",AllAmmReports.MissileKey)
Amm = combine(groupby( AllAmmReports, [:shipKey,:MissileKey]),  :TotalCarried=>sum)
AmmFlat = unstack(Amm,1,2,3,fill=0)

AllDecoyReports
AllDecoyReports.MissileKey = string.("DEC-",AllDecoyReports.MissileKey)
Decoy = combine(groupby( AllDecoyReports, [:shipKey,:MissileKey]),  :TotalCarried=>sum)
DecoyFlat = unstack(Decoy,1,2,3,fill=0)

EngFlat = unique(select(AllEngineeringReports, ["shipKey","RestoresTotal","DCTeamsCarried"]))
AllEngineeringReports
# And now combine all these together


HullInfo
ships = innerjoin(
    ships,
    select(HullInfo,["Class","Structural Integrity"]),
    on= :HullKey => :Class
)


leftjoin!(ships,WeaponsFlat,on=:shipKey)
leftjoin!(ships,missilesCarriedFlat,on=:shipKey)
leftjoin!(ships,ewwarFlat,on=:shipKey)
leftjoin!(ships,PdFlat,on=:shipKey)
leftjoin!(ships,DecoyFlat,on=:shipKey)
leftjoin!(ships,EngFlat,on=:shipKey)

# Ok, so now we want a matrix and a DataFrame with no missings
ships
unique(select(ships,Not(:shipKey)))
hullAttribs = select(ships,names(ships)[3:end])



select!(hullAttribs,Not("WEAP-Mk550 Mass Driver "))
names(hullAttribs)
# replace(hullAttribs, missing=>0 )
M = Matrix(first(hullAttribs,1000000))
replace!(M,missing => 0)
hullAttribs = DataFrame(M,names(hullAttribs))

M = convert(Array{Float64},disallowmissing(M))
Mu = unique(M,dims=1)
# Now we have the array, we can normalise it


r = - (pairwise(Euclidean() , Mu', dims = 2 ).^2 )

# r = .- (pairwise(Euclidean() , M', dims = 2 ) .+ rand.() ./10)

medR = median(r)
for i in 1:size(r, 1)
    r[i, i] = medR
end


clustering = affinityprop(r; maxiter=500, tol=1e-6, damp=0.5,display = :iter)

clustering.exemplars
clustering.assignments
mean(clustering.counts)

# ok, so need to join this back on to the og table

Mu

UniqueHullsDf = DataFrame(Mu,names(hullAttribs))
UniqueHullsDf.assignments = clustering.assignments


clusterAssignments = leftjoin(hullAttribs,UniqueHullsDf, on= names(hullAttribs))

out = sort(combine(groupby(clusterAssignments,:assignments),nrow),:nrow, rev = true)

plot(out.nrow)

allAssignments = filter(x->x.nrow > 250,out).assignments

filter(x->x.assignments ∈ allAssignments ,clusterAssignments)

clusterAssignments.hullKey = ships.HullKey

clusterAssignments
allAssignments



i = allAssignments[1]



look = filter(x->x.assignments == i ,clusterAssignments)

hullsOut = countmap(look.hullKey)

P = Matrix(select(look,names(look)[1:end-2]))
P2 = replace(P, missing=>0.0)

PCAOut = fit(PCA,P2';)

Norm = DataFrame(Norm = Float64[])

for i in 1:size(PCAOut.proj,1)
    push!(Norm,[norm(PCAOut.proj[i,:])])
end

Norm.Names = names(look)[1:end-2]
namesOut = first(sort!(Norm,:Norm,rev = true),15)


(hullsOut,namesOut)











function EachCluster(c1)

    # get the vals of this cluster
    inds = vcat(c1.core_indices,c1.boundary_indices)
    look = hullAttribs[inds,:]
    lookNorm = M_t[inds,:]

    look.miss .= 0

    missCols = []
    incCols = []



    mag = DataFrame(colNum = Int[],avMag = Float64[])

    for i in 1:size(lookNorm,2)

        push!(mag,(i,mean(lookNorm[:,i])))

    end
    sort!(mag,:avMag, rev = true)

    _colNames = first(mag,10).colNum
    _vecMag = first(mag,10).avMag
    _incColNames =  names(look)[_colNames]


    elementProp = []
    elementSum = []
    for i in _colNames

        push!(
            elementProp,
            sum(skipmissing(look[!,i]))/sum(skipmissing(hullAttribs[!,i])) 
        )
        push!(
            elementSum,
            mean(skipmissing(look[!,i])) 
        )

    end
    elementProp
    all = sort(DataFrame(element = _incColNames,_vecMag = _vecMag, prop = elementProp,mean = elementSum),:prop,rev = true)

    Hulls = countmap(ships[inds,:].HullKey)
        totalPtCost = ships[inds,:].OriginalPointCost

    minCost = minimum(totalPtCost)
    meanCost = round(mean(totalPtCost),digits=2)
    medianCost = median(totalPtCost)
    maxCost = maximum(totalPtCost)
    stdDevCost = round(std(totalPtCost),digits=2)
    clusterSz = size(totalPtCost,1)

    return (Hulls,
    all,
    # DataFrame(componenets = _incColNames),
    minCost,meanCost,medianCost,maxCost,stdDevCost,clusterSz)
end

cl = []

for i in clustering.clusters

        push!(cl,EachCluster(i))
end

cl[2]


AllShipReports.OriginalPointCost