using DuckDB
using DataFrames
using CSV
using StatsBase
using Random
using Dates

con = DBInterface.connect(DuckDB.DB,"nkb.db")

test = DBInterface.execute(con, """

    select * from raw.AllMatchReports limit 100;
    --select * from raw.sh limit 100;

""") |> DataFrame




match_ship_df = DBInterface.execute(con, """

    with 

    matchInfo as (
        select 
        GameKey,
        WinningTeam,
        Time,
        gameDuration
        from raw.AllMatchReports
        where Multiplayer is true and GameFInished is true
    ),

    teamInfo as (
        select 
        GameKey,
        AccountId,
        TeamID,
        PlayerID
        
        from raw.AllTeamReports
    ),

    shipInfo as (
        select 
        gameKey,
        AccountId,
        PlayerID,
        shipKey,
        HullKey[7:] as HullKey,
        OriginalPointCost,
        case when Eliminated = 'NotEliminated' then 0 else 1 end as Eliminated,
        EliminatedTimestamp,
        WasDefanged,
        DefangedTimestamp,
        TotalDamageReceived,
        TotalDamageDealt,
        AmmoPercentageExpended,

        from raw.AllShipReports
--         where OriginalPointCost < 3001

    ),

    teamPlusMatch as (
        select 
        teamInfo.GameKey,
        teamInfo.AccountId,
        teamInfo.TeamID,
        teamInfo.PlayerID,
        matchInfo.WinningTeam,
        matchInfo.gameDuration,
        case when teamInfo.TeamID = matchInfo.WinningTeam then 1 else 0 end as Win

        from teamInfo
        left join matchInfo
        on teamInfo.GameKey = matchInfo.GameKey
    ),

    tmPlusShip as (
        select 
        teamPlusMatch.GameKey,
        teamPlusMatch.AccountId,
        teamPlusMatch.gameDuration,
        teamPlusMatch.PlayerID,
        teamPlusMatch.Win,
        case 
            when shipInfo.HullKey in ('Sprinter Corvette','Raines Frigate','Keystone Destroyer','Vauxhall Light Cruiser','Axford Heavy Cruiser','Solomon Battleship') then 'ANS' 
            when shipInfo.HullKey in ('Shuttle','Tugboat','Bulk Feeder','Bulk Hauler','Ocello Cruiser','Container Hauler') then 'OSP' 
        else 'Unknown' end as Faction,

        shipInfo.shipKey,
        shipInfo.HullKey,
        shipInfo.OriginalPointCost,
        case when shipInfo.EliminatedTimestamp = 0 then 1 else shipInfo.EliminatedTimestamp/gameDuration end as EliminatedTimestamp,
        shipInfo.WasDefanged,
        case when shipInfo.DefangedTimestamp = 0 then 1 else shipInfo.DefangedTimestamp/gameDuration end as DefangedTimestamp,
        shipInfo.TotalDamageReceived,
        shipInfo.TotalDamageDealt,
        shipInfo.AmmoPercentageExpended

        from teamPlusMatch
        left join shipInfo
        on teamPlusMatch.GameKey = shipInfo.GameKey and teamPlusMatch.PlayerID = shipInfo.PlayerID
    ),

    -- rm weird cases
    rmWeird as (
        select * from tmPlusShip
        where OriginalPointCost == 0 or OriginalPointCost > 3000 or shipKey is null
    )


    select * from tmPlusShip
    
    where gamekey not in (select gamekey from rmWeird)
    --and gamekey = '18209990110252967495'

""") |> DataFrame

# I then want to write this out to csv
CSV.write("o2__match_ship_df.csv", match_ship_df)

# I want to create 2 lists of ships

ship = [
    "Sprinter Corvette",
    "Raines Frigate",
    "Keystone Destroyer",
    "Vauxhall Light Cruiser",
    "Axford Heavy Cruiser",
    "Solomon Battleship",
    # "Shuttle",
    # "Tugboat",
    # "Bulk Feeder",
    # "Bulk Hauler",
    # "Ocello Cruiser",
    # "Container Hauler"
]
shipURL = [
    "https://i.ytimg.com/vi/9OssXwvTe5I/maxresdefault.jpg",
    "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgi7dknm_FWIEQXipVLaSvcxTnC2182NbX_6XmfqIEBDgRi2OslWJUBzJW2yZhL4pc16jMYTrTA9OABgiAGJPotLOMjNj1AYhzcnnEfWrufr8PFeoATcZBrMUtakLdzemAegHUVmqbkN0fevSnnSpykmsmc9M-9YmZfSQpPnpVZxSKaQayb59WuICEiNA/s1920/20220623224301_1.jpg",
    "https://steamuserimages-a.akamaihd.net/ugc/1848179813067830972/F1932DFAEC59BF8C074B705BEDD309732476AE20/",
    "https://steamuserimages-a.akamaihd.net/ugc/1853809133504324201/76E09322738C25EFCE574EEB8E4A86ED5E5FE9EC/",
    "https://i.ytimg.com/vi/ug5aqvjO1mA/maxresdefault.jpg",
    "https://assets1.ignimgs.com/thumbs/userUploaded/2022/6/27/nebulousfleetcommandblog-1656338312637.jpg?width=1280",

]

shipURLDf = DataFrame(
    ship = ship,
    shipURL = shipURL
)
CSV.write("o2__shipURL4.csv", shipURLDf)

# Want to look at ship comparison:

match_ship_df

# I want to join these scallywags
# This just looks at the single bits and bobs

dfA = select(match_ship_df, :GameKey, :AccountId, :Faction, :Win, :shipKey => :shipKeyA, :HullKey=>:HullKeyA, :OriginalPointCost => :OriginalPointCostA, )
dfB = select(match_ship_df, :GameKey, :AccountId, :shipKey => :shipKeyB, :HullKey=>:HullKeyB, :OriginalPointCost => :OriginalPointCostB)

shipComparison = outerjoin(dfA, dfB, on = [:GameKey, :AccountId], makeunique=true)

for i in eachrow(shipComparison)
    if i.shipKeyA == i.shipKeyB
        i.shipKeyB = missing
        i.HullKeyB = ""
        i.OriginalPointCostB = 0
    end
end

shipComparison
CSV.write("o2__shipComparison.csv", shipComparison)

# filter!(row -> row.shipKeyA != row.shipKeyB, shipComparison)

shipByShipDF = combine(groupby(shipComparison, [:HullKeyA, :HullKeyB]), nrow => :hullCount, :Win => mean => :Win, 
    :OriginalPointCostA => mean => :OriginalPointCostA_mean, 
    :OriginalPointCostA => median => :OriginalPointCostA_median,
    :OriginalPointCostA => mean => :OriginalPointCostB_mean,
    :OriginalPointCostB => median => :OriginalPointCostB_median,
    
    )

sort(shipByShipDF,:Win)


    # ok, lets try have the hull counts in there too

    groupByFleet = combine(groupby(match_ship_df, [:GameKey, :, :Faction, :HullKey]), nrow => :hullCount, :OriginalPointCost .=> [mean median],  :Win => mean => :Win)

    groupedDfA = select(groupByFleet, :GameKey, :AccountId, :Faction, :Win, :HullKey=>:HullKeyA, :OriginalPointCost_mean => :OriginalPointCostA_mean, :OriginalPointCost_median => :OriginalPointCostA_median, :hullCount => :hullCountA)
    groupedDfB = select(groupByFleet, :GameKey, :AccountId, :Faction, :HullKey=>:HullKeyB, :OriginalPointCost_mean => :OriginalPointCostB_mean, :OriginalPointCost_median => :OriginalPointCostB_median, :hullCount => :hullCountB)

    groupedShipComparison = outerjoin(groupedDfA, groupedDfB, on = [:GameKey, :AccountId, :Faction,], makeunique=true)

    sort(groupedShipComparison, :Win)

    CSV.write("o2__groupedShipComparison2.csv", groupedShipComparison)

    
    # ok, lets look at winrate

winRateByPlayer = combine(groupby(match_ship_df, [:AccountId, ]),nrow => :count, :Win => mean => :Win)

CSV.write("o2__winRateByPlayer.csv", winRateByPlayer)

# Fuck this. Lets do a running sum properly:

match_ship_df




filter(row -> row.HullKey == "Keystone Destroyer", match_ship_df)