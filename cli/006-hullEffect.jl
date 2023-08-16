using Pkg, OrderedCollections,OneHotArrays, Dates, DataFrames, StatsBase, ProgressMeter, Plots, JLD2, PlotThemes, Distributions, StatsPlots
theme(:dark)
df = load_object("BattleReports/allGameData.jld2")
df


df.pointCost = ((parse.(Float64,df.OriginalPointCost)))
filter!(x->x.pointCost <= 3000,df)
filter!(x->x.pointCost != 0,df)


gdf = groupby(df,[:faction,:HullKey])

# wtf = filter(x->x.HullKey == "Stock/Shuttle" && x.pointCost > 2000,df)

function removeOutliers_IQR(data,IQRthreshold)
        
    # Calculate the interquartile range (IQR)
    q1 = quantile(data, 0.25)
    q3 = quantile(data, 0.75)
    iqr = q3 - q1

    # Set a threshold for outlier removal (e.g., 1.5 times the IQR)
    lower_bound = q1 - IQRthreshold * iqr
    upper_bound = q3 + IQRthreshold * iqr

    # Remove outliers
    filtered_data = filter(x -> lower_bound <= x <= upper_bound, data)
    return filtered_data
end

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

rateN = rate ./ max(maximum(rate),abs(minimum(rate)))
winRate = round(sum((winH .- lossH ))/size(k,1),digits = 3)

stephis = stephist(k.pointCost, group = WinLoss, bins =start:step:finish ,title = "$hullString, Winrate = $winRate")
xlims!(start, finish) 
ylabel!("Count")

# boxplot(zeros(Float64,size(k,1)),k.pointCost,outliers = false, orientation=:h, legend=false,whisker_width = 0.25,bar_width = 0.25)
pointEffectiveness = plot(collect(start:step:finish)[2:end],rateN,legend = false)

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



# Scratch
gdf[12]
maximum(gdf[12].pointCost)



A = filter(x->x.pointCost == 3000.0 && x.HullKey == "Stock/Bulk Feeder",df)
# Example dataset with outliers
data = gdf[12].pointCost

function removeOutliers_IQR(data,IQRthreshold)
        
    # Calculate the interquartile range (IQR)
    q1 = quantile(data, 0.25)
    q3 = quantile(data, 0.75)
    iqr = q3 - q1

    # Set a threshold for outlier removal (e.g., 1.5 times the IQR)
    lower_bound = q1 - IQRthreshold * iqr
    upper_bound = q3 + IQRthreshold * iqr

    # Remove outliers
    filtered_data = filter(x -> lower_bound <= x <= upper_bound, data)
    return filtered_data
end