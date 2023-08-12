using JLD2, Dates, DataFrames, StatsBase, ProgressMeter, PlotlyJS ,  PlotThemes 
# theme(:dark)
df = load_object("BattleReports/allGameData.jld2")
df

# This approach is baaaad
hullCnt = combine(groupby(df,[:HullKey,:faction]),nrow => :count)
size(unique(df.GameKey),1)
hullCnt.count = hullCnt.count  ./ size(unique(df.GameKey),1)

hullCnt

ANS=sort(filter(x->x.faction == "ANS",hullCnt),:count)
push!(ANS,ANS[1,:])

plot(scatterpolar(
    ANS,
    r=:count,
    theta=:HullKey,
    color=:faction,
    marker=attr(size=:frequency, sizeref=0.05), mode="lines"
))

OSP=sort(filter(x->x.faction == "OSP",hullCnt),:count)
push!(OSP,OSP[1,:])

plot(scatterpolar(
    OSP,
    r=:count,
    theta=:HullKey,
    color=:faction,
    marker=attr(size=:frequency, sizeref=0.05), mode="lines"
))