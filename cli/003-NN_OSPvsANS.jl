using Pkg, XML, XMLDict, OrderedCollections, Dates, DataFrames, Flux, CUDA, OneHotArrays, StatsBase, ProgressMeter, Plots, GLM, JLD2 


allGamesDf = load_object("BattleReports/allGameData.jld2")
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


# ok, so now I'll try OSP vs ANS

factionShipArray = zeros(12,0)
factionOutcomeArray = fill(true,0)
GameKeyVectorF = fill(hash(""),0)

test = filter(x->x.faction == "ANS",gdf[3])
sum(Array(onehotbatch(test.HullKey, ANSShips)),dims =2)

test.winningFaction[1] == "ANS"


for i in gdf

    if ("OSP" ∈ i.faction) && ("ANS" ∈ i.faction) # make sure battles have both factions

        tOSP = filter(x->x.faction == "OSP",i)
        tANS = filter(x->x.faction == "ANS",i)


        factionShipArray = hcat(factionShipArray, vcat(sum(Array(onehotbatch(tANS.HullKey, ANSShips)),dims =2),sum(Array(onehotbatch(tOSP.HullKey, OSPShips)),dims =2)))
        factionOutcomeArray = push!(factionOutcomeArray,tANS.winningFaction[1] == "ANS")
        push!(GameKeyVectorF,i.GameKey[1])

    end

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




