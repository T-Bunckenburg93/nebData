using Pkg, OrderedCollections,OneHotArrays, Dates, DataFrames, StatsBase, ProgressMeter, Plots, JLD2, PlotThemes, Distributions
theme(:dark)
df = load_object("BattleReports/allGameData.jld2")
df


df.pointCost = ((parse.(Float64,df.OriginalPointCost)))
filter!(x->x.pointCost <= 3000,df)
filter!(x->x.pointCost != 0,df)


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
