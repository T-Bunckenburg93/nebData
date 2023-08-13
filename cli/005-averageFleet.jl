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


    f = Figure(resolution = (800, 600))
    Axis(   f[1, 1],
            title = "Hull counts across games",
            yticks = ((1:size(c,1)),  (hullNames)),
            xlabel = "Hull Count",
            limits = ((nothing,15), nothing)
            
        )
    f
    for i in size(c,1):-1:1
        density!(
                c[i], 
                offset = i, 
                color = (:slategray, 0.4),
                npoints = 20,
                strokewidth = 1, 
                strokecolor = :White
                # bandwidth = 0.1
                )
    end
    set_theme!()
    f
end


ANSAvg= shipDist(filter(x->x.HullKey ∈ ANSShips,stacked))
OSPAvg = shipDist(filter(x->x.HullKey ∈ OSPShips,stacked))


save("docs/assets/avgFleet/ANSHullDensity.png", ANSAvg)
save("docs/assets/avgFleet/OSPHullDensity.png", OSPAvg)

# ok so now what are the average values ?

transposed_df = unstack(stacked,  :GameKey, :HullKey, :value)
games_hulls = coalesce.(transposed_df, 0)

avg = describe(select(games_hulls,Not(:GameKey)))[:,[1,2,4]]

CSV.write("avg.csv", avg)
