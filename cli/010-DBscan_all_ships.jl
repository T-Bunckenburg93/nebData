using Dates, DataFrames, OneHotArrays, StatsBase, Plots, JLD2, Clustering, CSV, Distances,ProgressMeter,MultivariateStats, LinearAlgebra, PrettyTables

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
unique(AllMissileReports.MissileKey)
AllMissileReports.MissileKey = string.("MIS-",AllMissileReports.MissileKey)
missilesCarried = combine(groupby( AllMissileReports, [:shipKey,:MissileKey]), :TotalCarried => sum)
missilesCarriedFlat = unstack(missilesCarried,1,2,3,fill=0)
names(missilesCarriedFlat)

AllEwarReports
AllEwarReports.GroupName = string.("EWAR-",AllEwarReports.GroupName)
ewar = combine(groupby( AllEwarReports, [:shipKey,:GroupName]),  nrow)
ewwarFlat = unstack(ewar,1,2,3,fill=0)

AllPdReports.GroupName = first.(split.(AllPdReports.GroupName,"-"))
AllPdReports
AllPdReports.GroupName = string.("PD-",AllPdReports.GroupName)
Pd = combine(groupby( AllPdReports, [:shipKey,:GroupName]),  :WeaponCount=>sum)
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


r = -(pairwise(Euclidean() , Mu', dims = 2 ).^2 )


medR = median(r)
for i in 1:size(r, 1)
    r[i, i] = medR
end


clustering = affinityprop(r; maxiter=500, tol=1e-6, damp=0.9,display = :iter)
# clustering2 = affinityprop(r; maxiter=200, tol=1e-6, damp=0.99,display = :iter)

clustering.exemplars
clustering.assignments
mean(clustering.counts)

# ok, so need to join this back on to the og table



UniqueHullsDf = DataFrame(Mu,names(hullAttribs))
UniqueHullsDf.assignments = clustering.assignments

# and put flags for the exemplars

exmp = fill(0,size(UniqueHullsDf,1))

for (i, val) in enumerate(clustering.exemplars)

    exmp[val] = i

end

unique(exmp)
# filter(x->x.assignments ∈ allAssignments ,clusterAssignments)


# insertcols!(clusterAssignments,1, :HullKey => ships.HullKey)
allAssignments = filter(x->x.nrow > 50,out).assignments
UniqueHullsDf.exemplars = exmp

clusterAssignments = leftjoin(hullAttribs,UniqueHullsDf, on= names(hullAttribs))
clusterAssignments.hullKey = ships.HullKey

out = sort(combine(groupby(clusterAssignments,:assignments),nrow),:nrow, rev = true)

ships.clusterAssignments=clusterAssignments.assignments
shipsWinR = select(ships,[:shipKey,:clusterAssignments,])

leftjoin!(shipsWinR,
unique(select(AllShipReports,["gameKey","shipKey","AccountId","Eliminated"])),
on=:shipKey
)

AllTeamReports

leftjoin!(shipsWinR,
unique(filter(x->x.AccountId != "0",select(AllTeamReports,["gameKey","AccountId","TeamID"]))),
on=[:gameKey , :AccountId]
)

leftjoin!(shipsWinR,
rename(unique(select(AllMatchReports,["GameKey","WinningTeam"])),:GameKey => :gameKey),
on=:gameKey
)


shipsWinR.win = shipsWinR.TeamID .==  shipsWinR.WinningTeam

replace!(shipsWinR.Eliminated,
    "Evacuated" => "Destroyed/Other",
    "Withdrew" => "Destroyed/Other",
    "Destroyed" => "Destroyed/Other",    
    "Retired" => "Destroyed/Other",
)

i = allAssignments[32]




function AFCluster(i::Int)

    look = filter(x->x.assignments == i ,clusterAssignments)

    hcnt = countmap(look.hullKey)
    hullsOut = sort(DataFrame(Hulls = collect(keys(hcnt)), Count = collect(values(hcnt))),:Count,rev=true)

    P = Matrix(select(look,names(look)[1:end-3]))
    P2 = replace(P, missing=>0.0)

    PCAOut = fit(PCA,P2';)

    # PCAOut.
    fieldnames(typeof(PCAOut))

    Norm = DataFrame(Names = String[],PCANorm = Float64[], meanVal = Float64[], proportion = Float64[], scaledProportion = Float64[])

    for i in 1:size(PCAOut.proj,1)

        avgValue =  mean(skipmissing(look[!,i]))
        proportion =  sum(skipmissing(look[!,i]))/sum(skipmissing(hullAttribs[!,i])) 
        scaledProportion = proportion * size(hullAttribs,1)/size(look,1)

        push!(Norm,["",norm(PCAOut.proj[i,:]),avgValue,proportion,scaledProportion])

    end


    Norm.Names = names(look)[1:end-3]
    namesOut = select(first(sort!(Norm,:scaledProportion,rev = true),15),[:Names,:meanVal,:proportion,:scaledProportion])

    # ok, now get the exemplar
    ex = first(filter(x->x.exemplars == i,clusterAssignments),1)

    eachcol(ex)[2]

    Cols2Keep = []
    for (i,val) in enumerate(eachcol(ex)[1:end-2])
        # try
            if !ismissing(val[1]) && val[1] > 0 
                push!(Cols2Keep,names(ex)[i])
            end
        # catch i 
        #     println(i)
        # end
    end
    # ex.variable .= 1
    exemplarAttribs = stack(select(ex,vcat("hullKey",Cols2Keep)),vcat("hullKey",Cols2Keep))

    filter!(x->x.variable != "assignments", exemplarAttribs)
    filter!(x->x.variable != "Structural Integrity", exemplarAttribs)
    filter!(x->x.Names != "Structural Integrity", namesOut)
    # namesOut
    # finally, get the winrate
    # filter(x->x.clusterAssignments == i ships)

    WR = filter(x->x.clusterAssignments == i, shipsWinR)
    WinOutcome = unstack(combine(groupby(filter(x->!ismissing(x.win),WR),[:win,:Eliminated]),nrow),:Eliminated,:win,:nrow,fill = 0)
    rename!(WinOutcome,Dict("true" => "Win", "false" => "Loss"))
    # Get size of wl
    sz = sum(WinOutcome."Win")+sum(WinOutcome."Loss")
    
    push!(WinOutcome,["Total",sum(WinOutcome."Win"),sum(WinOutcome."Loss")])
    WinOutcome.WinPct = round.(WinOutcome.Win ./ sz ,digits = 3)
    WinOutcome.LossPct = round.(WinOutcome.Loss ./ sz ,digits = 3)

    return(hullsOut,namesOut,exemplarAttribs,WinOutcome)
end


AFcl = []
allAssignments
for i in allAssignments
        push!(AFcl,AFCluster(i))
end

AFcl[1][4]

function getMDString(AFcl,i)

    # Format each DataFrame using PrettyTables
    Hulls = pretty_table(String,AFcl[i][1],header = names(AFcl[i][1]),tf = tf_markdown)
    Components = pretty_table(String,AFcl[i][2],header = names(AFcl[i][2]),tf = tf_markdown)
    Exemplar = pretty_table(String,AFcl[i][3],header = names(AFcl[i][3]),tf = tf_markdown)
    Outcome = pretty_table(String,AFcl[i][4],header = names(AFcl[i][4]),tf = tf_markdown)

    sz = sum(AFcl[i][1].Count)

    # Save the styled DataFrames to a Markdown file
    markdown_content = """
    ## Cluster $i, $sz hulls

    ### Hull Counts

    $Hulls

    ### Components

    $Components

    ### Exemplar

    $Exemplar

    ### Hull Outcome vs WinRate

    $Outcome

    """
    return markdown_content
end

getMDString(AFcl,1)


# so I want to create a bunch of MD strings that I then turn into MD
sz = size(AFcl,1)
MDString = """
# Cluster Info on $sz clusters

Here I'm doing a clustering analysis to build on the point distributon analysis I did initally. 
The most common response, and my thoughts while I was building it, was that point cost is not a simple indication of ship build, and thus outcome. So I've spent a bit of time refining it, primarily by adding a bunch of components into the mix. 

Ive tried to build a model that both accomodates common builds, but also includes more niche builds that do show up. 
This has led to some overlap, and prossibly some differential of clusters that doesn't really exist, as well as lots of clusters ( $sz ), but I do feel/hope that this is reasonable representative of the ships rolls that you can see in Nebulous.

## Description of the tables:

### Hull Counts
Hull count shuld be pretty obvious. Generally there is one, but often there is overlap 


### Components
Here I tried to identify the specific componenets that made up a cluster. 
* meanVal, is the average number of that value that you would expect to see on this rype of hull. 
* proportion, is the proportion of this component that is in this cluster. for example, the first group contains about 50% of all S1/rockets
* scaledProportion, is this, but scaled by the size of the cluster, to make this number more meaningful for smaller clusters. if you had a component 50% of the time, and the size of the cluster was 10% of all ships, this number would be 5

### Exemplar
Each cluster is focused around a single ship that serves at the exemplar. This is the hull/components that this exemplar had.

### Hull Outcome vs WinRate
Counts and Percentages of wins and losses vs the ship being eliminated or not. Ideally this should show if the cluster is effective or not.



Now I'm not going to do a writeup of each one, as there are $sz, but I do hope this is interesting. I will be using these clusters in the future to try and group fleet types, as I feel there is a lot of interesting things to unpack there.

Enjoy, and let me know what you think!

"""

for i in 1:size(AFcl,1)

    MDString = string(MDString,getMDString(AFcl,i))

end


    filename = "docs/Cluster_groups.md"
    open(filename, "w") do io
        print(io, MDString)
    end
