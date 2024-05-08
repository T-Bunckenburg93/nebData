using JLD2, Dates, DataFrames, StatsBase, ProgressMeter, CairoMakie, CSV
# theme(:dark)
AllReports = load_object("AllReports.jld2")

AllMatchReports = AllReports[1]
AllTeamReports = AllReports[2]
AllShipReports = AllReports[3]
AllWeaponReports = AllReports[6]
AllMissileReports = AllReports[7]

AllMatchReports.Time
unique(AllMatchReports.LobbyId)




names(AllWeaponReports)

select(AllMatchReports,[:GameKey,:WinningTeam])
select(AllTeamReports,[:GameKey,:AccountId,:TeamID])
select(AllShipReports,[:GameKey,:AccountId,:shipKey])


game2Ship = innerjoin(
    innerjoin(
        select(AllMatchReports,[:GameKey,:WinningTeam]),
        select(AllTeamReports,[:GameKey,:AccountId,:TeamID]),
        on = :GameKey
    ),
    select(AllShipReports,[:GameKey,:AccountId,:shipKey]),
    on = [:GameKey,:AccountId]
)


weps = leftjoin(
    game2Ship,
    AllWeaponReports,
    on = :shipKey
)

weps.win .= weps.TeamID .== weps.WinningTeam

weps

# So this is the total damage done for each player by weapon type for each game
weapAgg1 = combine(
    groupby(weps,[:GameKey,:AccountId,:WeaponKey]),
    # nrow, 
    :win => maximum,
    :TotalDamageDone => sum => :TotalDamageDone
    )


weapAgg2 = combine(
    groupby(weapAgg1,[:WeaponKey]),
    nrow,
    :win_maximum => mean,
    :TotalDamageDone .=> [mean, median]
)

a = names(AllShipReports)

sort!(weapAgg2,:win_maximum_mean)


