using JLD2, Dates, DataFrames, StatsBase, ProgressMeter, CairoMakie, CSV
# theme(:dark)
df = load_object("BattleReports/allGameData.jld2")
df

string_values = ["Win", "loss"]
df.win= (df.faction .== df.winningFaction)
df.WinLoss = [bit ? string_values[1] : string_values[2] for bit in df.win]

df.HullKey = replace.(df.HullKey,"Stock/"=> "")

gameHull = combine(groupby(df,[:GameKey,:HullKey]),nrow=>:count)
stacked = stack(gameHull, Not(:GameKey,:HullKey))

ANSShips = [
    "Solomon Battleship"
    "Axford Heavy Cruiser"
    "Vauxhall Light Cruiser"
    "Keystone Destroyer"
    "Raines Frigate"
    "Sprinter Corvette"
]
OSPShips = [
    "Container Hauler"
    "Bulk Hauler"
    "Ocello Cruiser"
    "Bulk Feeder"
    "Tugboat"
    "Shuttle"
]


function shipDist(stacked)

    set_theme!(theme_dark())
    transposed_df = unstack(stacked,  :GameKey, :HullKey, :value)
    games_hulls = coalesce.(transposed_df, 0)

    c = eachcol(games_hulls)[2:end]
    hullNames = names(c)

    hullSum = zeros(size(c,1))
    for i in 1:size(c,1)
        hullSum[i] = sum(c[i])
    end

    println(hullSum)


    f = Figure(resolution = (800, 600))
    Axis(   f[1, 1],
            title = "Hull proportions across matches (all fleets)",
            yticks = (collect((1:size(c,1)) .* 1.1),  string.(hullNames,", N = ",Int.(hullSum))),
            xlabel = "Hull Count",
            limits = ((-.6,15), nothing)
            
        )
    f

    for i in size(c,1):-1:1

        # hist( c[i], bins = size(unique(c[i]),1), color = :red, strokewidth = 1, strokecolor = :black)


        barplot!(
            collect(keys(countmap(c[i]))),
            collect(values(countmap(c[i]))) ./ maximum(collect(values(countmap(c[i])))), 
            offset = i + i*0.1 , 
            scale_to=1,
            color = (:slategray, 0.4),
            gap = 0,
            strokewidth = 1, 
            strokecolor = :White
            # bandwidth = 0.1
            )
            # offst = offst + maximum(collect(values(countmap(c[i]))))
    end
    set_theme!()
    f
end


hist( c[i], bins = size(unique(c[i]),1), color = :red, strokewidth = 1, strokecolor = :black)

ANSAvg= shipDist(filter(x->x.HullKey ∈ ANSShips,stacked))
OSPAvg = shipDist(filter(x->x.HullKey ∈ OSPShips,stacked))


save("docs/assets/avgFleet/ANSHullDensity.png", ANSAvg)
save("docs/assets/avgFleet/OSPHullDensity.png", OSPAvg)

c = filter(x->x.HullKey == "Raines Frigate",stacked).value
values(countmap(c))


# ok so now what are the average values ?

transposed_df = unstack(stacked,  :GameKey, :HullKey, :value)
games_hulls = coalesce.(transposed_df, 0)

avg = describe(select(games_hulls,Not(:GameKey)))[:,[1,2,4]]

CSV.write("avg.csv", avg)
