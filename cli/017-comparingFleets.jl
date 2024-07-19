using JLD2, Dates, CSV, DuckDB, DataFrames, Flux, StatsBase, LinearAlgebra, Random, Plots, ProgressMeter, CUDA, TSne, StatsPlots

"""
Gets the nth element of the vector x
"""
function getNth(x,n)
    x[n]
end

# create a new in-memory dabase
con = DBInterface.connect(DuckDB.DB,"nebData.db")

# DBInterface.execute(con, "PRAGMA database_list; ") |> DataFrame
r = DBInterface.execute(con, "PRAGMA show_tables; ")|> DataFrame

# I want to get fleets in a simple form

eng_final = DBInterface.execute(con, """
    select

        shipKey,
        RestoresTotal,
        DCTeamsCarried,
    
    from raw.AllEngineeringReports


""") |> DataFrame

unique!(eng_final)



ewar = DBInterface.execute(con, """
    select 
        shipKey,
            case 

                when WeaponKey = 'Stock/E90 ''Blanket'' Jammer' then 'jammer_radar'
                when WeaponKey = 'Stock/E55 ''Spotlight'' Illuminator' then 'illuminator_radar'
                when WeaponKey = 'Stock/J15 Jammer' then 'jammer_radar'
                when WeaponKey = 'Stock/L50 Laser Dazzler' then 'jammer_eo'
                when WeaponKey = 'Stock/E70 ''Interruption'' Jammer' then 'jammer_comms'
                when WeaponKey = 'Stock/J360 Jammer' then 'jammer_radar'
                when WeaponKey = 'Stock/E71 ''Hangup'' Jammer' then 'jammer_comms'
                when WeaponKey = 'Stock/E57 ''Floodlight'' Illuminator' then 'illuminator_radar'
                when WeaponKey = 'Stock/E20 ''Lighthouse'' Illuminator' then 'illuminator_radar'
    
        else ' ' end as EwarType,
        count(*) as cnt

    from raw.AllEwarReports
    group by shipKey, EwarType


""") |> DataFrame

ewarStack = stack(ewar,[:EwarType])
ewar_final = unstack(ewarStack,:shipKey,:value,:cnt)




weap = DBInterface.execute(con, """
    select 
        shipKey,
        Name,
        sum(RoundsCarried) as RoundsCarried

    from raw.AllWeaponReports
    where not Name ^@ '&lt;' -- rm chinese characters
    group by shipKey, Name

""") |> DataFrame


# unique!(weap.Name)

function getGun(x) 
    if isnothing(findfirst(x->x == '-',x))
        return x
    else
    return  x[1:findfirst(x->x == '-',x)-2]
    end
end
function getAmmoLoad(x)
    if isnothing(findfirst(x->x == '-',x))
        return ""
    else
        return x[findfirst(x->x == '-',x)+2:end]
    end
end

weap.GunName = getGun.(weap.Name)
weap.AmmoLoad = getAmmoLoad.(weap.Name)
weapGun = select(weap,[:shipKey,:GunName])

# Want to transpose to get binary indicators of guns on ships
weapGunStack = stack(weapGun,[:GunName])
weapGunStack.value = replace.(weapGunStack.value,' ' => '_','-' => '_')
weapGunStack.value = string.("gun_",weapGunStack.value)
weapGunStack = combine(groupby(weapGunStack,[:shipKey,:value]), nrow)
weapGunStack = combine(groupby(weapGunStack,[:shipKey,:value]), nrow)
weapGunStack_final = unstack(weapGunStack,:value,:nrow)

weapAmmo = select(weap,[:shipKey,:AmmoLoad,:RoundsCarried]) 
# get rid of laser turrets
filter!(x -> !ismissing(x.RoundsCarried)  ,weapAmmo)

weapAmmo = combine(groupby(weapAmmo,[:shipKey,:AmmoLoad]), :RoundsCarried => sum => :RoundsCarried)
weapAmmoStack = stack(weapAmmo,[:AmmoLoad])
weapAmmoStack.value = replace.(weapAmmoStack.value,' ' => '_','-' => '_')
weapAmmoStack.value = string.("ammo_",weapAmmoStack.value)
select!(weapAmmoStack,[:shipKey,:value,:RoundsCarried])
weapAmmoStack.RoundsCarried = Int64.(weapAmmoStack.RoundsCarried)
weapAmmoStack_final = unstack(weapAmmoStack,:value,:RoundsCarried)

weap_final = outerjoin(weapGunStack_final,weapAmmoStack_final,on=:shipKey)

amm = DBInterface.execute(con, """
    select 
        shipKey,
        MissileKey,
        sum(TotalCarried) as TotalCarried
    from raw.allammreports
    group by shipKey, MissileKey


""") |> DataFrame

ammStack = stack(amm,[:MissileKey])
ammStack.value = replace.(ammStack.value,' ' => '_','-' => '_','/' => '_')
ammStack.value = string.("amm_",ammStack.value)
amm_final = unstack(ammStack,:shipKey,:value,:TotalCarried)

decoy = DBInterface.execute(con, """
    select 
        shipKey,
        MissileKey,
        sum(TotalCarried) as TotalCarried
    from raw.alldecoyreports
    group by shipKey, MissileKey


""") |> DataFrame

# decoyStack = stack(decoy,[:MissileKey])
# decoyStack.value = replace.(decoyStack.value,' ' => '_','-' => '_','/' => '_')
# decoyStack.value = string.("decoy_",decoyStack.value)

# decoy_final = unstack(decoyStack,:shipKey,:value,:TotalCarried)


missile = DBInterface.execute(con, """
    select 
        shipKey,
        MissileKey,
        sum(TotalCarried) as TotalCarried
    from raw.allmissilereports
    group by shipKey, MissileKey


""") |> DataFrame

allMissile = vcat(missile,decoy,amm)
allMissile = combine(groupby(allMissile,[:shipKey,:MissileKey]), :TotalCarried => sum => :TotalCarried)
allMissile.TotalCarried = Int64.(allMissile.TotalCarried)


missileStack = stack(allMissile,[:MissileKey])
missileStack.value = replace.(missileStack.value,' ' => '_','-' => '_','/' => '_')
missileStack.value = string.("missile_",missileStack.value)
missile_final = unstack(missileStack,:shipKey,:value,:TotalCarried)


pd = DBInterface.execute(con, """
    select 
        shipKey,
        WeaponKey,
        WeaponCount,
        RoundsCarried

    from raw.allpdreports
    -- group by shipKey, WeaponKey
""") |> DataFrame


pd = combine(groupby(pd,[:shipKey,:WeaponKey]), :WeaponCount => sum => :WeaponCount, :RoundsCarried => maximum => :RoundsCarried)

pdStack = stack(pd,[:WeaponKey])
pdStack.value = replace.(pdStack.value,' ' => '_','-' => '_','/' => '_',''' => "")
unique(pdStack.value)

filter!(x -> x.value ∉ ["Stock_Mk62_Cannon","Stock_Mk64_Cannon","Stock_Mk64_Cannon","Stock_Mk61_Cannon","Stock_T20_Cannon","Stock_T30_Cannon"]  ,pdStack)

pdStack.value = string.("pd_",pdStack.value)
pd_final = unstack(pdStack,:shipKey,:value,:WeaponCount)

# and get the ammo stuff out
pdAmmo = select(pd,[:shipKey,:WeaponKey,:RoundsCarried])
unique(pdAmmo.WeaponKey)
replace!(pdAmmo.WeaponKey,
 "Stock/Mk20 Defender PDT" => "ammo_20mm Slug",
 "Stock/P11 PDT" =>"ammo_20mm Slug",
 "Stock/Mk29 Stonewall PDT" => "ammo_Flak Round",
 "Stock/Mk25 Rebound PDT" => "ammo_Flak Round",
 "Stock/P20 Flak PDT" => "ammo_Flak Round",
 "Stock/Mk95 Sarissa PDT" => "ammo_15mm Sandshot"
)
filter!(x -> startswith(x.WeaponKey,"ammo_")  ,pdAmmo)
pdAmmoStack = stack(pdAmmo,[:WeaponKey])
pdAmmoStack.value = replace.(pdAmmoStack.value,' ' => '_','-' => '_','/' => '_')
pdAmmoStack = combine(groupby(pdAmmoStack,[:shipKey,:value]), :RoundsCarried => maximum => :RoundsCarried)
pdAmmoStack_final = unstack(pdAmmoStack,:shipKey,:value,:RoundsCarried)

weapAmmoStack_final = outerjoin(weapAmmoStack_final,pdAmmoStack_final,on=:shipKey)


ship = DBInterface.execute(con, """
    select 
    GameKey,
    AccountId,
    shipKey,
    HullKey,
    OriginalPointCost
    
    from raw.allshipreports

""") |> DataFrame

ship.HullKey

ship.HullKey = chop.(ship.HullKey,head = 6,tail = 0)
ship.HullKey = replace.(ship.HullKey," " => "_")


# and join them together



leftjoin!(ship,eng_final,on=:shipKey)
leftjoin!(ship,ewar_final,on=:shipKey)
leftjoin!(ship,weap_final,on=:shipKey)
# leftjoin!(ship,amm_final,on=:shipKey)
# leftjoin!(ship,decoy_final,on=:shipKey)
leftjoin!(ship,missile_final,on=:shipKey)
leftjoin!(ship,pd_final,on=:shipKey)

# ok, so here is train data.

# now I want to ingest fleet file

println(names(ship))
ship

# ok, need to find out who won the game

tr  = DBInterface.execute(con, """
    select 
    t1.GameKey,
    t1.AccountId,
    t1.TeamID,
    t2.WinningTeam


    from raw.AllTeamReports t1
    left join raw.AllMatchReports t2 on t1.GameKey = t2.GameKey
    where t2.GameKey is not null and Multiplayer is true
    and t2.GameKey not in ('8695760503043932688','3174366872913984729','282407690666330478')

""") |> DataFrame

tr.win = tr.WinningTeam .== tr.TeamID
result = select(tr,[:GameKey,:AccountId,:win])

trainDF = innerjoin(result,ship,on=[:GameKey,:AccountId])
# sort!(trainDF,:win)
ship

# trainDF.win2 = trainDF.win .+ randn(size(trainDF,1))

    # make zero if missing
trainDF = coalesce.(trainDF,0)
trainDF

combine(groupby(trainDF,[:GameKey,:AccountId,:win]),nrow)

ux = ["Sprinter_Corvette", "Raines_Frigate", "Vauxhall_Light_Cruiser", "Keystone_Destroyer", "Bulk_Hauler", "Tugboat", "Shuttle", "Bulk_Feeder", "Ocello_Cruiser", "Axford_Heavy_Cruiser", "Solomon_Battleship", "Container_Hauler"]


println(ux)
trainDF = transform(trainDF, @. :HullKey => ByRow(isequal(ux)) .=> Symbol(:HullKey_, ux))
select!(trainDF, Not(:HullKey))

trainDF[:,80:end]

trainDF[2,:]

# X = Float64.(Matrix(select(trainDF, Not(:GameKey,:AccountId,:win,:shipKey))))
# dt = fit(ZScoreTransform, X, dims=1)
# X2 = StatsBase.transform(dt, X)

# trainDFNorm = hcat(select(trainDF, [:GameKey,:AccountId,:win,:shipKey]), DataFrame(X2,names(trainDF)[5:end]))
trainDFNorm = trainDF


toMekeShips = filter(x->x.nrow > 10, combine(groupby(trainDFNorm,[:GameKey,:AccountId,:win]),nrow))

trainDFNorm = antijoin(trainDFNorm,toMekeShips,on = :GameKey)
trainDFNorm[:,80:end]
# trainDFNorm.win2 = trainDFNorm.win

function getWeights(fleet)
    maxshipSz = 10
    fl = [collect(i) for i in eachrow(Matrix(fleet[!,names(fleet)[5:end]]))]
    # and pad the length
    shipSz = size(fl,1)
    varSz = size(fl[1],1)
    for i in 1:maxshipSz-shipSz
        push!(fl,zeros(varSz))
    end
    return mapreduce(permutedims, vcat, fl)
    # return fl
end


sz = 860
# gw = getWeights(groupby(trainDFNorm,[:GameKey,:AccountId,:win])[1])
# # want to turn this into a single row

# collect(reshape(gw',1,sz))


train = [collect(reshape(getWeights(f)[shuffle(1:end), :]',1,sz)) for f in groupby(trainDFNorm,[:GameKey,:AccountId,:win])]
outcome1 = [f.win[1] for f in groupby(trainDFNorm,[:GameKey,:AccountId,:win])]

@showprogress for i in 1:10

    train = vcat(train,[collect(reshape(getWeights(f)[shuffle(1:end), :]',1,sz)) for f in groupby(trainDFNorm,[:GameKey,:AccountId,:win])])
    outcome1 = vcat(outcome1,[f.win[1] for f in groupby(trainDFNorm,[:GameKey,:AccountId,:win])])

end

train

train2 = mapreduce(permutedims, hcat, train)
outcome = rotl90(hcat(outcome1,.!outcome1))


trainDFNorm
trainDFNorm.win

# train2 = rotl90(Matrix(trainDFNorm[!,5:end]))

# noisy = rand(Float32, 2, 10000)                                  # 2×1000 Matrix{Float32}
# truth = [xor(col[1]>0.5, col[2]>0.5) for col in eachcol(noisy)]   # 1000-element Vector{Bool}


target = Flux.onehotbatch(outcome1, [true, false])                   # 2×1000 OneHotMatrix
loader = Flux.DataLoader((train2, target) |> gpu, batchsize=50000, shuffle=true)


# inputSz = size(train[1],2)*size(train[1],1)
inputSz = size(train2,1)
# inputSz = 2
hiddenSz = 50


# Define our model, a multi-layer perceptron with one hidden layer of size 3:
model = Chain(
    Dense(inputSz => hiddenSz, tanh),   # activation function inside layerhiddenSz
    # BatchNorm(hiddenSz),
    Dense(hiddenSz => hiddenSz, tanh),   # activation function inside layerhiddenSz
    # Dense(hiddenSz => hiddenSz, tanh),   # activation function inside layerhiddenSz
    # Dense(hiddenSz => hiddenSz, tanh),   # activation function inside layerhiddenSz
    # Dense(hiddenSz => hiddenSz, tanh),   # activation function inside layerhiddenSz
    # Dense(hiddenSz => hiddenSz, sigmoid),   # activation function inside layerhiddenSz

    # Dense(hiddenSz => 10),  # output layer
    
    # BatchNorm(10),
    Dense(hiddenSz => 2),
    softmax
) |> gpu        # move model to GPU, if available

optim = Flux.setup(Flux.Adam(0.01), model)  # will store optimiser momentum, etc.

# Training loop, using the whole data set 1000 times:
losses = []

@showprogress for epoch in 1:125
    for (x, y) in loader
        losss, grads = Flux.withgradient(model) do m
            # Evaluate model and loss inside gradient context:
            y_hat = m(x)
            Flux.logitcrossentropy(y_hat, y)
            # Flux.msle(y_hat, y)
        end
        Flux.update!(optim, model, grads[1])
        # push!(grad, grads[1])
        push!(losses, losss)  # logging, outside gradient context
    end
end

plot(losses)
# losses[1:100]


# cor(train2[1,:],trainDFNorm.win)

optim # parameters, momenta and output have all changed
train2[:,1:10000]

out2 = model(train2 |> gpu) |> cpu  # first row is prob. of true, second row p(false)
# probs2 = softmax(out2)      # normalise to get probabilities
mean((out2[1,:] .> 0.5) .== outcome1)  # accuracy 94% so far!
density(out2[1,:])

out2[1]
out2[2]
out2[3]
out2[4]
out2[5]
out2[6]
out2[7]
out2[8]

out2 = Float64.(out2)


look = filter(x->x.GameKey ==10902300151816910222,innerjoin(result,ship,on=[:GameKey,:AccountId]))




m = model |> cpu
jldsave("fleetModel.jld2";m)
m = load_object("fleetModel.jld2")

