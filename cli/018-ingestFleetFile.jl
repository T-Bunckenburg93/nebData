using Pkg, XML, XMLDict, OrderedCollections, Dates, DataFrames, StatsBase, ProgressMeter, CSV, DuckDB, JLD2, Flux, Random, StatsPlots,Distances

function showFields(u;fields = [])
    duds = []
    _type = typeof(u)

    if isempty(fields)
        fields = fieldnames(_type)
    else
        duds = setdiff(fields,fieldnames(_type))
        fields = intersect(fields,fieldnames(_type))
    end

    for i in fields
        println(i, ": ", getfield(u,i))


        if length(duds) > 0
            println("The following fields are not valid fields for the $_type type: ",duds)
            println("Valid fields are: ",fieldnames(_type))
        end
    end
    return
end

import Base.tryparse

function tryparse(type,A,default) 
    x = tryparse(type,A)
    if isnothing(x)
        return default
    else
        return x
    end
end

"""
Gets the nth element of the vector x
"""
function getNth(x,n)
    x[n]
end


"""
Function to check if a string is ascii and repalce non ascii chars with ?
"""
function convert2Ascii(s,replacement='?')

    if isascii(s)
        return s 
    else 
        return replace(s, !isascii=>'?')
    end
end
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
function findElement(node::Node,elementName::String,debug=true)

    childrenNodeNames = tag.(children(node))

    nodeWeWant = findfirst(x->x==elementName,childrenNodeNames)
    
    if nodeWeWant != nothing
    
        return children(node)[nodeWeWant]
    
    elseif debug == true
        println("Node: ",elementName, " doesn't exist")
        println("Printing all nodes: ")
        println.("   ",childrenNodeNames)
        return
    end
end
function findElement(node::Node)
    findElement(node,"",true)
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
        x = value(children(findElement(node,element,false))[1])
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


function getFleet(fleetPath, _wr = 0.5)

    doc = read(fleetPath, Node)
    Fleet = findElement(doc,"Fleet")
    ships = findElement(Fleet,"Ships")
    # missileTypes = findElement(Fleet,"MissileTypes")

    fleetDF = DataFrame()

    # ship = ships[1]

    for ship in children(ships)

        pointCost = getElementValue(ship,"Cost")
        hullType = getElementValue(ship,"HullType")
        components = findElement(ship,"SocketMap")

        df = DataFrame()

        comp = []
        ammo = []
        miss = []
        types = []

        for c in children(components)
            compName = getElementValue(c,"ComponentName")
            push!(comp,compName)
            # now we look at what is in the componet 
            if !isnothing(findElement(c,"ComponentData",false))
                componentData = findElement(c,"ComponentData")
                push!(types,componentData.attributes["xsi:type"])
                # get magazine load 
                if componentData.attributes["xsi:type"] == "BulkMagazineData"
                    
                    load = findElement(componentData,"Load")

                    # println(typeof(getElementValue(children(load)[1],"Quantity")))

                    for mag in children(load)
                        push!(ammo,(
                            getElementValue(mag,"MunitionKey"),
                            getElementValue(mag,"Quantity")
                        ))
                    end
                end
                # and get missile info
                if componentData.attributes["xsi:type"] in  ["CellLauncherData" , "ResizableCellLauncherData"]
                    
                    MissileLoad = findElement(componentData,"MissileLoad")

                    for misLoad in children(MissileLoad)
                        push!(miss,(
                            getElementValue(misLoad,"MunitionKey"),
                            getElementValue(misLoad,"Quantity")
                        ))
                    end
                end
            end


        end
        types
        miss
        missDf = DataFrame()

        if length(miss) == 0
            missDf = DataFrame(MissileKey = [],Quantity = [])
        else
            missDf = DataFrame(miss,[:MissileKey,:Quantity])
        end
        missDf.Quantity = parse.(Int,missDf.Quantity)

        function rmJunkNames(MissileKey)
                
            MissileKey = replace(MissileKey,"""\$MODMIS\$""" => "Stock")

            MissileKey = replace(MissileKey,
                "Stock/SGM-H-3" => "Stock/SGM-H-3 Body ∈",
                "Stock/SGM-H-2" => "Stock/SGM-H-2 Body ∈",
                "Stock/SGM-1" => "Stock/SGM-1 Body ∈",
                "Stock/SGM-2" => "Stock/SGM-2 Body ∈",
                "Stock/SGM-3" => "Stock/SGM-3 Body ∈",
                "Stock/SGM-4" => "Stock/SGM-4 Body ∈",
                
                
            )
            if occursin('∈',MissileKey)
                return MissileKey[1:findfirst(x->x == '∈',"Stock/SGM-1 Body ∈")]
            else
                return MissileKey
            end
            

        end
        # println(missDf.MissileKey)
        missDf.MissileKey = rmJunkNames.(missDf.MissileKey)
        # println(missDf.MissileKey)


        missDf_final = combine(groupby(missDf,:MissileKey), :Quantity => sum)
        rename!(missDf_final,:MissileKey => :var,:Quantity_sum => :val)

        ammoDF = DataFrame()
        if length(ammo) == 0
            ammoDF = DataFrame(var = [],val = [])
        else
            ammoDF = DataFrame(ammo,[:var,:val])
        end
        ammoDF.val = parse.(Int,ammoDF.val)

        # println(ammoDF.val)

        # ammoDF.val = Int.(ammoDF.val)
        # println(eltype.(eachcol(ammoDF)))
        # ammoDF = DataFrame(ammo,[:var,:val])
        # ammoDF.val = tryparse.(Int,ammoDF.val,0)

        # compDf
        # compDf_final = combine(groupby(compDf,:ComponentName), nrow => :count)
        ammoDF
        missDf_final

        compDf = DataFrame(var = [],val = [])
        append!(compDf,DataFrame(var = comp,val = 1))

        restoreDict = Dict(
        "Stock/Reinforced DC Locker" => 1,
        "Stock/Large DC Locker" => 2,
        "Stock/Small DC Locker" => 1,
        "Stock/Large DC Storage" => 4,
        "Stock/Damage Control Complex" => 2,
        )

        DCTeamDict = Dict(
        "Stock/Reinforced DC Locker" => 1,
        "Stock/Large DC Locker" => 2,
        "Stock/Small DC Locker" => 1,
        "Stock/Large DC Storage" => 1,
        "Stock/Damage Control Complex" => 3,
        "Stock/Rapid DC Locker" => 1,
        )


        JammerDict = Dict(
        "Stock/E90 'Blanket' Jammer" => "jammer_radar",
        "Stock/E55 'Spotlight' Illuminator" => "illuminator_radar",
        "Stock/J15 Jammer" => "jammer_radar",
        "Stock/L50 Laser Dazzler" => "jammer_eo",
        "Stock/E70 'Interruption' Jammer" => "jammer_comms",
        "Stock/J360 Jammer" => "jammer_radar",
        "Stock/E71 'Hangup' Jammer" => "jammer_comms",
        "Stock/E57 'Floodlight' Illuminator" => "illuminator_radar",
        "Stock/E20 'Lighthouse' Illuminator" => "illuminator_radar",
        )


        for i in eachrow(compDf)

            if i.var in keys(restoreDict)
                push!(compDf,("RestoresTotal",restoreDict[i.var]))
            end
            if i.var in keys(DCTeamDict)
                push!(compDf,("DCTeamsCarried",DCTeamDict[i.var]))
            end
            if i.var in keys(JammerDict)
                push!(compDf,(JammerDict[i.var],1))
            end

        end
        compDf
        push!(compDf,("OriginalPointCost",parse(Int,pointCost)))
        # push!(compDf,("HullType",hullType))

        compDf
        missDf_final
        ammoDF

        allFeatures = vcat(
                compDf,
                missDf_final,
                ammoDF)


        allFeatures.var = replace.(allFeatures.var ,''' => "")
        # println(allFeatures.var)

        # feature names

        allFeatureNames = 
        [
        #  "GameKey"
        #  "AccountId"
        "shipKey"
        "HullKey"
        "OriginalPointCost"
        # "OriginalCrew"
        "RestoresTotal"
        "DCTeamsCarried"
        # "CriticalComponentCount"
        "jammer_radar"
        "illuminator_radar"
        "jammer_eo"
        "jammer_comms"
        "gun_Mk62_Cannon"
        "gun_Mk64_Cannon"
        "gun_Mk600_Beam_Cannon"
        "gun_T81_Plasma_Cannon"
        "gun_T30_Cannon"
        "gun_C53_Cannon"
        "gun_T20_Cannon"
        "gun_C30_Cannon"
        "gun_C56_Cannon"
        "gun_C90_Cannon"
        "gun_Mk66_Cannon"
        "gun_TE45_Mass_Driver"
        "gun_Mk610_Beam_Turret"
        "gun_Mk65_Cannon"
        "gun_C81_Plasma_Cannon"
        "gun_Mk61_Cannon"
        "gun_Mk68_Cannon"
        "gun_Mk81_Railgun"
        "gun_C65_Cannon"
        "gun_Mk550_Railgun"
        "gun_C60_Cannon"
        "gun_Mk550_Mass_Driver"
        "ammo_120mm_HE_RPF_Shell"
        "ammo_120mm_AP_Shell"
        "ammo_120mm_HE_Shell"
        "ammo_250mm_HE_RPF_Shell"
        "ammo_250mm_HE_Shell"
        "ammo_250mm_AP_Shell"
        "ammo_400mm_Plasma_Ampoule"
        "ammo_100mm_AP_Shell"
        "ammo_100mm_HE_HC_Shell"
        "ammo_100mm_Grape"
        "ammo_100mm_HE_Shell"
        "ammo_600mm_Bomb_Shell"
        "ammo_600mm_HE_SH_Shell"
        "ammo_450mm_AP_Shell"
        "ammo_450mm_HE_Shell"
        "ammo_500mm_Fracturing_Block"
        "ammo_300mm_AP_Rail_Sabot"
        "missile_Stock_SGM_H_3_Body"
        "missile_Stock_SGM_1_Body"
        "missile_Stock_SGT_3_Body"
        "missile_Stock_SGM_H_2_Body"
        "missile_Stock_SGM_2_Body"
        "missile_Stock_S3_Sprint_Mine"
        "missile_Stock_S3_Net_Mine"
        "missile_Stock_Rocket_Container_12"
        "missile_Stock_S1_Rocket"
        "missile_Stock_CM_4_Body"
        "missile_Stock_Decoy_Container_(Line_Ship)"
        "missile_Stock_Mine_Container"
        "missile_Stock_CM_S_4_Body"
        "missile_Stock_Decoy_Container_(Clipper)"
        "missile_Stock_S3_Mine"
        "missile_Stock_Rocket_Container"
        "missile_Stock_EA12_Chaff_Decoy"
        "missile_Stock_EA20_Flare_Decoy"
        "missile_Stock_EA99_Active_Decoy"
        "pd_Stock_Mk20_Defender_PDT"
        "pd_Stock_Mk29_Stonewall_PDT"
        "pd_Stock_P11_PDT"
        "pd_Stock_P60_Laser_PDT"
        "pd_Stock_L50_Laser_Dazzler"
        "pd_Stock_Mk90_Aurora_PDT"
        "pd_Stock_Mk95_Sarissa_PDT"
        "pd_Stock_Mk25_Rebound_PDT"
        "pd_Stock_P20_Flak_PDT"]

        # apply mapping to mke it line up with the features in the model
        replace!(allFeatures.var,
        "Stock/Mk61 Cannon" => "gun_Mk61_Cannon"
        ,"Stock/Mk62 Cannon" => "gun_Mk62_Cannon"
        ,"Stock/Mk64 Cannon" => "gun_Mk64_Cannon"
        ,"Stock/Mk600 Beam Cannon" => "gun_Mk600_Beam_Cannon"
        ,"Stock/T81 Plasma Cannon" => "gun_T81_Plasma_Cannon"
        ,"Stock/T30 Cannon" => "gun_T30_Cannon"
        ,"Stock/C53 Cannon" => "gun_C53_Cannon"
        ,"Stock/T20 Cannon" => "gun_T20_Cannon"
        ,"Stock/C30 Cannon" => "gun_C30_Cannon"
        ,"Stock/C56 Cannon" => "gun_C56_Cannon"
        ,"Stock/C90 Cannon" => "gun_C90_Cannon"
        ,"Stock/Mk66 Cannon" => "gun_Mk66_Cannon"
        ,"Stock/TE45 Mass Driver" => "gun_TE45_Mass_Driver"
        ,"Stock/Mk610 Beam Turret" => "gun_Mk610_Beam_Turret"
        ,"Stock/Mk65 Cannon" => "gun_Mk65_Cannon"
        ,"Stock/C81 Plasma Cannon" => "gun_C81_Plasma_Cannon"
        ,"Stock/Mk61 Cannon" => "gun_Mk61_Cannon"
        ,"Stock/Mk68 Cannon" => "gun_Mk68_Cannon"
        ,"Stock/Mk81 Railgun" => "gun_Mk81_Railgun"
        ,"Stock/C65 Cannon" => "gun_C65_Cannon"
        ,"Stock/Mk550 Railgun" => "gun_Mk550_Railgun"
        ,"Stock/C60 Cannon" => "gun_C60_Cannon"
        ,"Stock/Mk550 Mass Driver" => "gun_Mk550_Mass_Driver"
        ,"Stock/120mm HE RPF Shell" => "ammo_120mm_HE_RPF_Shell"
        ,"Stock/120mm AP Shell" => "ammo_120mm_AP_Shell"
        ,"Stock/120mm HE Shell" => "ammo_120mm_HE_Shell"
        ,"Stock/250mm HE RPF Shell" => "ammo_250mm_HE_RPF_Shell"
        ,"Stock/250mm HE Shell" => "ammo_250mm_HE_Shell"
        ,"Stock/250mm AP Shell" => "ammo_250mm_AP_Shell"
        ,"Stock/400mm Plasma Ampoule" => "ammo_400mm_Plasma_Ampoule"
        ,"Stock/100mm AP Shell" => "ammo_100mm_AP_Shell"
        ,"Stock/100mm HE HC Shell" => "ammo_100mm_HE_HC_Shell"
        ,"Stock/100mm Grape" => "ammo_100mm_Grape"
        ,"Stock/100mm HE Shell" => "ammo_100mm_HE_Shell"
        ,"Stock/600mm Bomb Shell" => "ammo_600mm_Bomb_Shell"
        ,"Stock/600mm HE SH Shell" => "ammo_600mm_HE_SH_Shell"
        ,"Stock/450mm AP Shell" => "ammo_450mm_AP_Shell"
        ,"Stock/450mm HE Shell" => "ammo_450mm_HE_Shell"
        ,"Stock/500mm Fracturing Block" => "ammo_500mm_Fracturing_Block"
        ,"Stock/300mm AP Rail Sabot" => "ammo_300mm_AP_Rail_Sabot"
        ,"Stock/SGM H 3 Body" => "missile_Stock_SGM_H_3_Body"
        ,"Stock/SGM 1 Body" => "missile_Stock_SGM_1_Body"
        ,"Stock/SGT 3 Body" => "missile_Stock_SGT_3_Body"
        ,"Stock/SGM H 2 Body" => "missile_Stock_SGM_H_2_Body"
        ,"Stock/SGM 2 Body" => "missile_Stock_SGM_2_Body"
        ,"Stock/S3 Sprint Mine" => "missile_Stock_S3_Sprint_Mine"
        ,"Stock/S3 Net Mine" => "missile_Stock_S3_Net_Mine"
        ,"Stock/Rocket Container 12" => "missile_Stock_Rocket_Container_12"
        ,"Stock/S1 Rocket" => "missile_Stock_S1_Rocket"
        ,"Stock/CM 4 Body" => "missile_Stock_CM_4_Body"
        ,"Stock/Decoy Container (Line Ship)" => "missile_Stock_Decoy_Container_(Line_Ship)"
        ,"Stock/Mine Container" => "missile_Stock_Mine_Container"
        ,"Stock/CM S 4 Body" => "missile_Stock_CM_S_4_Body"
        ,"Stock/Decoy Container (Clipper)" => "missile_Stock_Decoy_Container_(Clipper)"
        ,"Stock/S3 Mine" => "missile_Stock_S3_Mine"
        ,"Stock/Rocket Container" => "missile_Stock_Rocket_Container"
        ,"Stock/EA12 Chaff D" => "missile_Stock_EA12_Chaff_Decoy"
        ,"Stock/EA20 Flare D" => "missile_Stock_EA20_Flare_Decoy"
        ,"Stock/EA99 Active " => "missile_Stock_EA99_Active_Decoy"
        ,"Stock/Mk20 Defender PDT" => "pd_Stock_Mk20_Defender_PDT"
        ,"Stock/Mk29 Stonewall PDT" => "pd_Stock_Mk29_Stonewall_PDT"
        ,"Stock/P11 PDT" => "pd_Stock_P11_PDT"
        ,"Stock/P60 Laser PDT" => "pd_Stock_P60_Laser_PDT"
        ,"Stock/L50 Laser Dazzler" => "pd_Stock_L50_Laser_Dazzler"
        ,"Stock/Mk90 Aurora PDT" => "pd_Stock_Mk90_Aurora_PDT"
        ,"Stock/Mk95 Sarissa PDT" => "pd_Stock_Mk95_Sarissa_PDT"
        ,"Stock/Mk25 Rebound PDT" => "pd_Stock_Mk25_Rebound_PDT"
        ,"Stock/P20 Flak PDT" => "pd_Stock_P20_Flak_PDT"
        )


        allFeatures = combine(groupby(allFeatures,:var), :val => sum => :val)
        allFeatures.shipKey .= 1

        allFeaturesStack_final = unstack(allFeatures,:shipKey,:var,:val)
        allFeaturesStack_final.HullKey .= hullType
        allFeaturesStack_final

        Symbol.(allFeatureNames)
        # create a dataframe with all the cols
        finalDF = DataFrame([name => Int64[] for name in allFeatureNames])

        df = vcat(finalDF,allFeaturesStack_final,cols=:union)
        select!(df, allFeatureNames)

        # and make the missing values 0
        df = coalesce.(df,0)
        df.win_rate .= _wr

        append!(fleetDF,df,promote=true)
    end
    return fleetDF
end




# shipTypes = ["Sprinter_Corvette", "Raines_Frigate", "Vauxhall_Light_Cruiser", "Keystone_Destroyer", "Bulk_Hauler", "Tugboat", "Shuttle", "Bulk_Feeder", "Ocello_Cruiser", "Axford_Heavy_Cruiser", "Solomon_Battleship", "Container_Hauler"]

function fleet2Vec(_fleet)

    fleet =deepcopy(_fleet)

    shipTypes = ["Sprinter_Corvette", "Raines_Frigate", "Vauxhall_Light_Cruiser", "Keystone_Destroyer", "Bulk_Hauler", "Tugboat", "Shuttle", "Bulk_Feeder", "Ocello_Cruiser", "Axford_Heavy_Cruiser", "Solomon_Battleship", "Container_Hauler"]

    fleet.HullKey = chop.(fleet.HullKey,head = 6,tail = 0)
    fleet.HullKey = replace.(fleet.HullKey," " => "_")

    # println(fleet.HullKey[1] )

    fleet = transform(fleet, @. :HullKey => ByRow(isequal(shipTypes)) .=> Symbol(:HullKey_, shipTypes))
    select!(fleet, Not(:HullKey))

    maxshipSz = 10
    fl = [collect(i) for i in eachrow(Matrix(fleet[!,names(fleet)[2:end]]))]
    # and pad the length
    shipSz = size(fl,1)
    varSz = size(fl[1],1)
    for i in 1:maxshipSz-shipSz
        push!(fl,zeros(varSz))
    end
    flatten = mapreduce(permutedims, vcat, fl)
    return collect(reshape(flatten[shuffle(1:end), :]',1,870))[1,:]
    # return flatten
end



function scorefleet(x,wr = 0.5)

    fleetName = split(x,'/')[end]
    fleet = getFleet(x,wr)
    allPerms = [fleet2Vec(fleet) for i in 1:1000 ]
    allPerms = stack(allPerms)
    
    all = m(
            allPerms
    )[1,:]
    
    return mean(all), density(all, xlimits=(-0.1,1.1),title=fleetName,)
end

m = load_object("fleetModel.jld2")



savePath = "C:/Program Files (x86)/Steam/steamapps/common/Nebulous/Saves/Fleets/"
saves = readdir(savePath)

findall(x->startswith(uppercase(x),"VXXX"),saves)

fleetsLocal = joinpath.(savePath,readdir(savePath))



fleetsLocal[190]
# fleet2Vec(getFleet(fleetsLocal[11]))


# v = fleet2Vec(getFleet(fleetsLocal[21]))

# dot.(v[1,:],v[2,:])

wrVar = []
for i in 0.1:0.1:1.0
    push!(wrVar,scorefleet(fleetsLocal[190],i)[1])
end

wrVar

look = scorefleet(fleetsLocal[190])[1]



look[1]
look[2]

eg = fleet2Vec(getFleet(fleetsLocal[190]))

# Cosine Similarity calculation
function cosine_similarity(x, y)
    return dot(x, y) / (norm(x) * norm(y))
end



allCS = []
for i in eachcol(train2[:,1:1000])

    push!(allCS,cosine_similarity(i,eg))

end

mean(allCS)



allFleets = []

for i in fleetsLocal
    if endswith(i,".fleet")
        push!(allFleets,scorefleet(i))
    end
end

allFleets







