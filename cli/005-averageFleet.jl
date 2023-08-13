using JLD2, Dates, DataFrames, StatsBase, ProgressMeter, CairoMakie, CSV
# theme(:dark)
df = load_object("BattleReports/allGameData.jld2")
df

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


    f = Figure()
    Axis(   f[1, 1],
            title = "Hull counts across games",
            yticks = ((1:size(c,1)),  (hullNames)),
            xlabel = "Hull Count",
            limits = ((nothing,20), nothing)
            
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


# ok so now what are the average values ?

transposed_df = unstack(stacked,  :GameKey, :HullKey, :value)
games_hulls = coalesce.(transposed_df, 0)

avg = describe(select(games_hulls,Not(:GameKey)))[:,[1,2,4]]

CSV.write("avg.csv", avg)

# with_theme(demofigure, theme_dark())





# This approach is baaaad
hullCnt = combine(groupby(df,[:HullKey,:faction]),nrow => :count)
size(unique(df.GameKey),1)
hullCnt.count = hullCnt.count  ./ size(unique(df.GameKey),1)

hullCnt

ANS=sort(filter(x->x.faction == "ANS",hullCnt),:count)
push!(ANS,ANS[1,:])

ANSAvg = plot(scatterpolar(
    ANS,
    r=:count,
    theta=:HullKey,
    color=:faction,
    marker=attr(size=:frequency, sizeref=0.05), mode="lines"
))

open("docs/_includes/ANSAvg.html", "w") do io
    PlotlyBase.to_html(io, ANSAvg.plot)
end

PlotlyJS.savefig(ANSAvg, "docs/assets/avgFleet/ansAvgFleet.png")


OSP=sort(filter(x->x.faction == "OSP",hullCnt),:count)
push!(OSP,OSP[1,:])

OPSAvg = plot(scatterpolar(
    OSP,
    r=:count,
    theta=:HullKey,
    color=:faction,
    marker=attr(size=:frequency, sizeref=0.05), mode="lines"
))

open("docs/_includes/OSPAvg.html", "w") do io
    PlotlyBase.to_html(io, OPSAvg.plot)
end

savefig(OPSAvg, "docs/assets/avgFleet/ospAvgFleet.png")
