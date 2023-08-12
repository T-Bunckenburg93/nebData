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

# manually build the input to score a battle
test = fill(0.0,24)
test[1] = 1 # add an axeford
test[end-2] =2 # add 2 other ships

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

