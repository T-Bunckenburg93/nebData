using Pkg, OrderedCollections,OneHotArrays, Dates, DataFrames, StatsBase, ProgressMeter, Plots, JLD2, PlotThemes, Distributions
theme(:dark)
df = load_object("BattleReports/allGameData.jld2")
df


df.pointCost = ((parse.(Float64,df.OriginalPointCost)))
filter!(x->x.pointCost <= 3000,df)
filter!(x->x.pointCost != 0,df)


gdf = groupby(df,[:faction,:HullKey])

# wtf = filter(x->x.HullKey == "Stock/Shuttle" && x.pointCost > 2000,df)


function hullEffectiveness(k)
# k = gdf[2]

hullString = replace(k.HullKey[1],"Stock/"=> ""," "=> "_")

minHullCost = floor(minimum(k.pointCost)/100)*100
maxHullCost = round(maximum(k.pointCost)/100)*100
# get win outcomes
k.win= (k.faction .== k.winningFaction)

# Define the string values you want to use
string_values = ["Win", "loss"]
# Convert BitVector to a vector of custom string values
WinLoss = [bit ? string_values[1] : string_values[2] for bit in k.win]

# get point limits
start = minHullCost
step = 100
finish = maxHullCost + 100

w = filter(x->x.win  == 1,k )
l = filter(x->x.win  == 0,k )

# get histograms of pointcosts for winning and losing
winH = fit(Histogram, w.pointCost, start:step:finish).weights
lossH = fit(Histogram, l.pointCost, start:step:finish).weights

rate = ((winH .- lossH )) .* sqrt.(sqrt.(winH) .+ sqrt.(lossH) )

rate = rate ./ max(maximum(rate),abs(minimum(rate)))
winRate = round(sum((winH .- lossH ))/size(k,1),digits = 3)

stephis = stephist(k.pointCost, group = WinLoss, bins =start:step:finish ,title = "$hullString, Winrate = $winRate")
xlims!(start, finish) 
ylabel!("Count")


pointEffectiveness = plot(collect(start:step:finish)[2:end],rate,legend = false)

xlims!(start, finish)
ylims!(-1,1)
xlabel!("Point Cost")
ylabel!("win/Loss")

p = plot(stephis, pointEffectiveness, layout=(2,1),size=(800,600),dpi=300,)

savefig(p,"docs/assets/pointEffectiveness/$hullString.png") 
p
end
hullEffectiveness(gdf[12])


for i in gdf

hullEffectiveness(i)
end

# ok so who wins more??

ggdf = groupby(df,[:GameKey])

winner = fill("",size(ggdf,1))

for i in 1:size(ggdf,1)

    winner[i] = ggdf[i].winningFaction[1]
end

x = countmap(winner)
winner

keys(x)
values(x)

vals = collect(values(x))
labs = collect(keys(x))

Wins = DataFrame(faction = labs,wins = vals)

Wins.pct = Wins.wins ./ sum(Wins.wins)

Wins


winner

# Count the occurrences of each outcome
observed_counts = countmap(winner)

# Expected counts for a fair coin
total_flips = length(winner)
expected_counts = Dict("ANS" => total_flips / 2, "OSP" => total_flips / 2)


# Chi square test by scratch

x2 = sum(((values(observed_counts) .- values(expected_counts)).^2) ./ values(expected_counts))

# x2 = sum((values(expected_counts) .- 5).^2 ./ values(expected_counts))
# x2 = sum(1 ./ values(expected_counts))

p = 1 - cdf(Chisq(1),x2)

# So the probability that the two factions are balanced (on paper) is pretty low, as OSP wins more. 
# However, this isn't a huuuuge difference, and I suspect comes down to the influx of rookies 
# Playing ANS
