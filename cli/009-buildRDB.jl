using Pkg, XML, XMLDict, OrderedCollections, Dates, DataFrames, OneHotArrays, StatsBase, ProgressMeter, Plots, JLD2 


# so the goal of this, is to turn a neb battle report into a single row that could be fed into a NN.
# Initally I think a row for each ship. 

# Here is the code that gets us to here:

"""
```
findElement(node::Node,elementName::String)
```

This function seaches the child elements of node, and returns the first one specified

If there is no match, then the child elements are printed
"""
function findElement(node::Node,elementName::String,debug=true)

    childrenNodeNames = tag.(children(node))

    nodeWeWant = findfirst(x->x==elementName,childrenNodeNames)
    
    if nodeWeWant != nothing
    
        return children(node)[nodeWeWant]
    
    elseif debug == true
        println("Node: ",elementName, " doesn't exist")
        println("Printing all nodes: ")
        println.("   ",childrenNodeNames)
        return
    end
end
function findElement(node::Node)
    findElement(node,"",true)
end
# findElement(doc,"FullAfterActionReport")


"""
```
function getElementValue(ShipsNode)
```
assumes that there is a single value under the node, tries to pull it out, else returns ""
"""
function getElementValue(node::Node,element::String)::String
    x = nothing
    try 
        x = value(children(findElement(node,element,debug=false))[1])
    catch e

    end

    if x == nothing
        return ""
    else
        return x
    end
end
function getElementValue(node::Node,nothing)::String
return ""
end

"""
Gets the nth element of the vector x
"""
function getNth(x,n)
    x[n]
end


# OK, so I want a function that takes in a battle report, and creates a bunch of tables, that can then be linked.
# This is so I can then use SQL to take all the tables that I currently have.


# Get a whole bunch of game info
"""
Takes a FullAfterActionReport node, and returns a single row DF
"""
function matchInfo(FullAfterActionReport::Node)

    try

        GameFinished = tryparse(Bool,getElementValue(FullAfterActionReport,"GameFinished"))
        GameStartTimestamp = tryparse(Int64,getElementValue(FullAfterActionReport,"GameStartTimestamp"))
        WinningTeam = getElementValue(FullAfterActionReport,"WinningTeam")
        LocalPlayerWon = tryparse(Bool,getElementValue(FullAfterActionReport,"LocalPlayerWon"))
        LocalPlayerSpectator = tryparse(Bool,getElementValue(FullAfterActionReport,"LocalPlayerSpectator"))
        LocalPlayerTeam = tryparse(Bool,getElementValue(FullAfterActionReport,"LocalPlayerTeam"))
        Multiplayer = tryparse(Bool,getElementValue(FullAfterActionReport,"Multiplayer"))
        LobbyId = getElementValue(findElement(FullAfterActionReport,"LobbyId"),"Value")

        Time = tryparse(DateTime,(getElementValue(FullAfterActionReport,"Time")[1:end-4]))

        # create a hash so that (hopefully) games saved from 2 different players, gets picked up
        GameKey = hash(string(Multiplayer,Time,LobbyId,WinningTeam,GameStartTimestamp,GameFinished))

        dfOut = DataFrame(
            GameKey = GameKey,
            Multiplayer=Multiplayer,
            Time=Time,
            LobbyId=LobbyId,
            WinningTeam=WinningTeam,
            GameStartTimestamp=GameStartTimestamp,
            GameFinished = GameFinished,
            LocalPlayerWon = LocalPlayerWon,
            LocalPlayerSpectator = LocalPlayerSpectator,
            LocalPlayerTeam = LocalPlayerTeam,
        )

        return GameKey, dfOut

    catch e
        println(_filename)
    end

end


"""
"""
function teamInfo(Node,gameKey=hash(""))
    try 
        teamdf = DataFrame()

        for t in children(Node)

            TeamID = getElementValue(t,"TeamID")

            Players = findElement(t,"Players")
            # get the player info
            for p in children(Players)

                AccountId = getElementValue(findElement(p,"AccountId"),"Value")
                PlayerID = getElementValue(p,"PlayerID")
                PlayerName = getElementValue(p,"PlayerName")
                Colors = findElement(p,"Colors")
                FleetPrefix = getElementValue(Colors,"FleetPrefix")

                

                all = DataFrame(
                    gameKey=gameKey,
                    AccountId=AccountId,
                    TeamID=TeamID,
                    PlayerName=PlayerName,
                    PlayerID=PlayerID,
                    FleetPrefix=FleetPrefix            
                    )

                append!(teamdf,all,promote=true)
            end

        end

        return teamdf
    catch e
        println("Error Parsing TeamInfo")
    end
end
# Teams = findElement(FullAfterActionReport,"Teams")
# teamInfo(Teams)

"""
Takes a Engineering Node and returns a DataFrame
"""
function EngineeringReport(Engineering)
    eDF = DataFrame(
        Efficiency = tryparse(Float64,getElementValue(Engineering,"Efficiency")),
        Rating = getElementValue(Engineering,"Rating"),
        OptimumPower = tryparse(Int64,getElementValue(Engineering,"OptimumPower")),
        AveragePower = tryparse(Int64,getElementValue(Engineering,"AveragePower")),
        PeakPowerDemand = tryparse(Int64,getElementValue(Engineering,"PeakPowerDemand")),
        TotalGameTime = tryparse(Float64,getElementValue(Engineering,"TotalGameTime")),
        ImmobilizedDuration = tryparse(Int64,getElementValue(Engineering,"ImmobilizedDuration")),
        AverageThrusterCond = tryparse(Float64,getElementValue(Engineering,"AverageThrusterCond")),
        DamageRepaired = tryparse(Float64,getElementValue(Engineering,"DamageRepaired")),
        RestoresTotal = tryparse(Int64,getElementValue(Engineering,"RestoresTotal")),
        RestoresConsumed = tryparse(Int64,getElementValue(Engineering,"RestoresConsumed")),
        RestoresDestroyed = tryparse(Int64,getElementValue(Engineering,"RestoresDestroyed")),
        RestoresRemaining = tryparse(Int64,getElementValue(Engineering,"RestoresRemaining")),
        CriticalComponentCount = tryparse(Int64,getElementValue(Engineering,"CriticalComponentCount")),
        CriticalComponentsLeftDestroyed = tryparse(Int64,getElementValue(Engineering,"CriticalComponentsLeftDestroyed")),
        DCTeamsCarried = tryparse(Int64,getElementValue(Engineering,"DCTeamsCarried")),
        DCTeamsSurvived = tryparse(Int64,getElementValue(Engineering,"DCTeamsSurvived")),
        DCTeamsHeavyCasualties = tryparse(Int64,getElementValue(Engineering,"DCTeamsHeavyCasualties")),
    )
    return eDF
end

Int64

"""
Takes a Defenses Node and returns 2 DataFrames
"""
function DefencesReport(Defenses)
    pdDF = DataFrame()
    ammDF = DataFrame()
    decoyDF = DataFrame() 
    # DefensesAll = DataFrame() 

    if !isnothing(Defenses)

        # DefensesAll = DataFrame(
        #     GameStartTime = getElementValue(Defenses,"GameStartTime"),
        #     TimeOfFirstTrack = getElementValue(Defenses,"TimeOfFirstTrack")
        # )

        WeaponReports = findElement(Defenses,"WeaponReports")
        MissileReports = findElement(Defenses,"MissileReports")
        DecoyReports = findElement(Defenses,"DecoyReports")

        for DefensiveWeaponReport in children(WeaponReports)
            WeaponCount = getElementValue(DefensiveWeaponReport,"WeaponCount")
            Weapon = findElement(DefensiveWeaponReport,"Weapon")

            df = DataFrame(
                Name = getElementValue(Weapon,"Name"),
                GroupName = getElementValue(Weapon,"GroupName"),
                WeaponKey = getElementValue(Weapon,"WeaponKey"),
                MaxDamagePerShot = tryparse(Int64,getElementValue(Weapon,"MaxDamagePerShot")),
                TotalDamageDone = tryparse(Float64,getElementValue(Weapon,"TotalDamageDone")),
                TargetsAssigned = tryparse(Int64,getElementValue(Weapon,"TargetsAssigned")),
                TargetsDestroyed = tryparse(Int64,getElementValue(Weapon,"TargetsDestroyed")),
                RoundsCarried = tryparse(Int64,getElementValue(Weapon,"RoundsCarried")),
                ShotsFired = tryparse(Int64,getElementValue(Weapon,"ShotsFired")),
                ShotsFiredOverTimeLimit = tryparse(Float64,getElementValue(Weapon,"ShotsFiredOverTimeLimit")),
                HitCount = tryparse(Int64,getElementValue(Weapon,"HitCount")),
                ShotDuration = tryparse(Float64,getElementValue(Weapon,"ShotDuration",)),
                CanBattleshort = getElementValue(Weapon,"CanBattleshort",),
            )
            df.WeaponCount .= WeaponCount
            append!(pdDF,df,promote=true)
        end

        for DefensiveMissileReport in children(MissileReports)
            # WeaponCount = getElementValue(DefensiveWeaponReport,"WeaponCount")
            # Weapon = findElement(DefensiveWeaponReport,"Weapon")

            df = DataFrame(
                MissileName = getElementValue(DefensiveMissileReport,"MissileName"),
                MissileDesc = getElementValue(DefensiveMissileReport,"MissileDesc"),
                MissileKey = getElementValue(DefensiveMissileReport,"MissileKey"),
                TotalCarried = tryparse(Int64,getElementValue(DefensiveMissileReport,"TotalCarried")),
                TotalTargets = tryparse(Int64,getElementValue(DefensiveMissileReport,"TotalTargets")),
                TotalExpended = tryparse(Int64,getElementValue(DefensiveMissileReport,"TotalExpended")),
                TotalInterceptions = tryparse(Int64,getElementValue(DefensiveMissileReport,"TotalInterceptions")),
                TotalSuccesses = tryparse(Int64,getElementValue(DefensiveMissileReport,"TotalSuccesses")),
            )
            # df.WeaponCount .= WeaponCount
            append!(ammDF,df,promote=true)
        end

        for DecoyReport in children(DecoyReports)
            # WeaponCount = getElementValue(DefensiveWeaponReport,"WeaponCount")
            # Weapon = findElement(DefensiveWeaponReport,"Weapon")

            df = DataFrame(
                MissileName = getElementValue(DecoyReport,"MissileName"),
                MissileDesc = getElementValue(DecoyReport,"MissileDesc"),
                MissileKey = getElementValue(DecoyReport,"MissileKey"),
                TotalCarried = tryparse(Int64,getElementValue(DecoyReport,"TotalCarried")),
                TotalExpended = tryparse(Int64,getElementValue(DecoyReport,"TotalExpended")),
                TotalSeductions = tryparse(Int64,getElementValue(DecoyReport,"TotalSeductions")),
            )
            # df.WeaponCount .= WeaponCount
            append!(decoyDF,df,promote=true)
        end
    end
    return pdDF, ammDF, decoyDF

end

"""
Takes a Sensors Node and returns 2 DataFrames
"""
function SensorsReport(Sensors)
    sDF = DataFrame()

    SensorsAll = DataFrame(
        GameStartTime = tryparse(Int64,getElementValue(Sensors,"GameStartTime")),
        TimeOfFirstTrack = tryparse(Int64,getElementValue(Sensors,"TimeOfFirstTrack")),
        PeakTracksHeld = tryparse(Int64,getElementValue(Sensors,"PeakTracksHeld")),
        TotalTimeJammed = tryparse(Float64,getElementValue(Sensors,"TotalTimeJammed")),
        TracksLostToJamming = tryparse(Float64,getElementValue(Sensors,"TracksLostToJamming")),
        TotalTimeTrackingEnemy = tryparse(Int64,getElementValue(Sensors,"TotalTimeTrackingEnemy")),
        TotalTimeTrackedByEnemy = tryparse(Int64,getElementValue(Sensors,"TotalTimeTrackedByEnemy")),
        TotalStealthTrackingTime = tryparse(Int64,getElementValue(Sensors,"TotalStealthTrackingTime")),
        StealthEfficiency = tryparse(Float64,getElementValue(Sensors,"StealthEfficiency")),
        TimeAtSensorEMCON = tryparse(Float64,getElementValue(Sensors,"TimeAtSensorEMCON")),
        TimeAtTotalEMCON = tryparse(Float64,getElementValue(Sensors,"TimeAtTotalEMCON")),
    )

    EWWeapons = findElement(Sensors,"EWWeapons")

    for i in children(EWWeapons)

        df = DataFrame(
            Name = getElementValue(i,"Name"),
            GroupName = getElementValue(i,"GroupName"),
            WeaponKey = getElementValue(i,"WeaponKey"),
            MaxDamagePerShot = tryparse(Int64,getElementValue(i,"MaxDamagePerShot")),
            TotalDamageDone = tryparse(Int64,getElementValue(i,"TotalDamageDone")),
            TargetsAssigned = tryparse(Int64,getElementValue(i,"TargetsAssigned")),
            TargetsDestroyed = tryparse(Int64,getElementValue(i,"TargetsDestroyed")),
            RoundsCarried = tryparse(Int64,getElementValue(i,"RoundsCarried")),
            ShotsFired = tryparse(Int64,getElementValue(i,"ShotsFired")),
            ShotsFiredOverTimeLimit = tryparse(Float64,getElementValue(i,"ShotsFiredOverTimeLimit",)),
            HitCount = tryparse(Int64,getElementValue(i,"HitCount")),
            ShotDuration = tryparse(Float64,getElementValue(i,"ShotDuration",)),
            CanBattleshort = tryparse(Float64,getElementValue(i,"CanBattleshort",)),

        )

        append!(sDF,df,promote=true)
    end
    return sDF,SensorsAll

end

"""
Takes a AntiShipReport Node and returns a DataFrame
"""
function StrikeReport(Strike)
    sDF = DataFrame()

    missiles = findElement(Strike,"Missiles")
    Efficiency = getElementValue(Strike,"Efficiency")
    Rating = getElementValue(Strike,"Rating")
    for i in children(missiles)

        df = DataFrame(
            MissileName = getElementValue(i,"MissileName"),
            MissileDesc = getElementValue(i,"MissileDesc"),
            MissileKey = getElementValue(i,"MissileKey"),
            TotalCarried = tryparse(Int64,getElementValue(i,"TotalCarried")),
            TotalExpended = tryparse(Int64,getElementValue(i,"TotalExpended")),
            IndividualDamagePotential = tryparse(Int64,getElementValue(i,"IndividualDamagePotential")),
            TotalDamageDone = tryparse(Float64,getElementValue(i,"TotalDamageDone")),
            Hits = tryparse(Int64,getElementValue(i,"Hits")),
            Misses = tryparse(Int64,getElementValue(i,"Misses")),
            Softkills = tryparse(Int64,getElementValue(i,"Softkills")),
            Hardkills = tryparse(Int64,getElementValue(i,"Hardkills")),
            # Efficiency=Efficiency,
            # Rating=Rating,

        )

        append!(sDF,df,promote=true)
    end
    return sDF

end

"""
Takes a AntiShipReport Node and returns a DataFrame
"""
function AntiShipReport(AntiShip)
    asDF = DataFrame()

    weapons = findElement(AntiShip,"Weapons")
    Efficiency = getElementValue(AntiShip,"Efficiency")
    Rating = getElementValue(AntiShip,"Rating")
    for i in children(weapons)

        df = DataFrame(
            Name = getElementValue(i,"Name"),
            GroupName = getElementValue(i,"GroupName"),
            WeaponKey = getElementValue(i,"WeaponKey"),
            MaxDamagePerShot = tryparse(Float64,getElementValue(i,"MaxDamagePerShot")),
            TotalDamageDone = tryparse(Float64,getElementValue(i,"TotalDamageDone")),
            TargetsAssigned = tryparse(Int64,getElementValue(i,"TargetsAssigned")),
            TargetsDestroyed = tryparse(Int64,getElementValue(i,"TargetsDestroyed")),
            RoundsCarried = tryparse(Int64,getElementValue(i,"RoundsCarried")),
            ShotsFired = tryparse(Int64,getElementValue(i,"ShotsFired")),
            HitCount = tryparse(Int64,getElementValue(i,"HitCount")),
            # Efficiency=Efficiency,
            # Rating=Rating,

        )

        append!(asDF,df,promote=true)
    end
    return asDF

end

"""
Takes a PartStatus Node and returns a DataFrame
"""
function PartStatusReport(PartStatus)
    psDF = DataFrame(
        Key = String[],
        HealthPercent = Float64[],
        IsDestroyed = String[]
    )
    for i in children(PartStatus)

        Key = getElementValue(i,"Key")
        HealthPercent = tryparse(Float64,getElementValue(i,"HealthPercent"))
        IsDestroyed = getElementValue(i,"IsDestroyed")

        push!(psDF,(Key,HealthPercent,IsDestroyed),promote=true)
    end
    return psDF

end

"""
Takes a EngagementHistory Node and returns a DataFrame
"""
function EngagementHistoryReport(EngagementHistory)
    psDF = DataFrame(
        Name = String[],
        TN = Int64[],
        EndingStatus = String[]
    )
    for EnemyEngagement in children(EngagementHistory)

        Name = getElementValue(EnemyEngagement,"Name")
        TN = parse(Int64,collect(values(XML.attributes(findElement(EnemyEngagement,"TN"))))[1])
        EndingStatus = getElementValue(EnemyEngagement,"EndingStatus")
        

        push!(psDF,(Name,TN,EndingStatus))
    end
    return psDF

end


# ok so now we want the ship info
function shipInfo(Node,gameKey=hash(""))

    shipdf = DataFrame()
    partStatusDf = DataFrame()
    EngagementHistDF = DataFrame()
    AntiShipDF = DataFrame()
    StrikeDF = DataFrame()
    SensorsDF = DataFrame()
    SensorsHighLevelDF = DataFrame()
    DefensesAll = DataFrame()
    PointDefenceDF = DataFrame()
    AmmDF = DataFrame()
    DecoyDF = DataFrame()
    EngineeringDF = DataFrame()

    for t in children(Node)

        Players = findElement(t,"Players")
        # get the player info
        for p in children(Players)

            AccountId = getElementValue(findElement(p,"AccountId"),"Value")
            Ships = findElement(p,"Ships")

                for s in children(Ships)

                    ShipName = getElementValue(s,"ShipName")
                    HullString = getElementValue(s,"HullString")
                    HullKey = getElementValue(s,"HullKey")
                    Eliminated = getElementValue(s,"Eliminated")
                    EliminatedTimestamp = tryparse(Int64,getElementValue(s,"EliminatedTimestamp"))
                    WasDefanged = tryparse(Bool,getElementValue(s,"WasDefanged"))
                    DefangedTimestamp = tryparse(Int64,getElementValue(s,"DefangedTimestamp"))
                    OriginalCrew = tryparse(Int64,getElementValue(s,"OriginalCrew"))
                    FinalCrew = tryparse(Int64,getElementValue(s,"FinalCrew"))
                    TotalDamageReceived = tryparse(Int64,getElementValue(s,"TotalDamageReceived"))
                    TotalDamageRepaired = tryparse(Int64,getElementValue(s,"TotalDamageRepaired"))
                    TotalDamageDealt = tryparse(Int64,getElementValue(s,"TotalDamageDealt"))
                    Condition = tryparse(Float64,getElementValue(s,"Condition"))
                    TotalTimeInContact = tryparse(Int64,getElementValue(s,"TotalTimeInContact"))
                    OriginalPointCost = tryparse(Int64,getElementValue(s,"OriginalPointCost"))
                    TotalDistanceTravelled = tryparse(Float64,getElementValue(s,"TotalDistanceTravelled"))
                    AmmoPercentageExpended = tryparse(Float64,getElementValue(s,"AmmoPercentageExpended"))

                    shipKey = hash(string(
                        gameKey,
                        AccountId,
                        ShipName,
                        HullString,
                        HullKey,
                        Eliminated,
                        EliminatedTimestamp,
                        WasDefanged,
                        DefangedTimestamp,
                        OriginalCrew,
                        FinalCrew,
                        TotalDamageReceived,
                        TotalDamageRepaired,
                        TotalDamageDealt,
                        Condition,
                        TotalTimeInContact,
                        OriginalPointCost,
                        TotalDistanceTravelled,
                        AmmoPercentageExpended,
                    ))

                    all = DataFrame(
                        gameKey=gameKey,
                        AccountId=AccountId,
                        shipKey=shipKey,
                        ShipName=ShipName,
                        HullString=HullString,
                        HullKey=HullKey,
                        Eliminated=Eliminated,
                        EliminatedTimestamp=EliminatedTimestamp,
                        WasDefanged=WasDefanged,
                        DefangedTimestamp=DefangedTimestamp,
                        OriginalCrew=OriginalCrew,
                        FinalCrew=FinalCrew,
                        TotalDamageReceived=TotalDamageReceived,
                        TotalDamageRepaired=TotalDamageRepaired,
                        TotalDamageDealt=TotalDamageDealt,
                        Condition=Condition,
                        TotalTimeInContact=TotalTimeInContact,
                        OriginalPointCost=OriginalPointCost,
                        TotalDistanceTravelled=TotalDistanceTravelled,
                        AmmoPercentageExpended=AmmoPercentageExpended,
                    )

                append!(shipdf,all,promote=true)

                    # ok so now we do the the other components.

                    PartStatus = findElement(s,"PartStatus")
                        psr = PartStatusReport(PartStatus)

                        insertcols!(psr,1,:shipKey => fill(shipKey,size(psr,1)))

                        append!(partStatusDf,psr; cols = :union,promote=true)

                    EngagementHist = findElement(s,"EngagementHistory",false)
                        ehr = EngagementHistoryReport(EngagementHist)

                        insertcols!(ehr,1,:shipKey => fill(shipKey,size(ehr,1)))

                        append!(EngagementHistDF,ehr; cols = :union,promote=true)

                    AntiShip = findElement(s,"AntiShip",false)
                        asr = AntiShipReport(AntiShip)

                        insertcols!(asr,1,:shipKey => fill(shipKey,size(asr,1)))

                        append!(AntiShipDF,asr; cols = :union)

                    Strike = findElement(s,"Strike")
                        mr = StrikeReport(Strike)

                        insertcols!(mr,1,:shipKey => fill(shipKey,size(mr,1)))

                        append!(StrikeDF,mr; cols = :union)

                    Sensors = findElement(s,"Sensors")
                        sr = SensorsReport(Sensors)[1]
                        shlr = SensorsReport(Sensors)[2]

                        insertcols!(sr,1,:shipKey => fill(shipKey,size(sr,1)))
                        insertcols!(shlr,1,:shipKey => fill(shipKey,size(shlr,1)))
                        
                        append!(SensorsDF,sr; cols = :union)
                        append!(SensorsHighLevelDF,shlr; cols = :union)


                    Defenses = findElement(s,"Defenses",false)
                        D = DefencesReport(Defenses)

                        insertcols!(D[1],1,:shipKey => fill(shipKey,size(D[1],1)))
                        insertcols!(D[2],1,:shipKey => fill(shipKey,size(D[2],1)))
                        insertcols!(D[3],1,:shipKey => fill(shipKey,size(D[3],1)))

                        append!(PointDefenceDF,D[1]; cols = :union)
                        append!(AmmDF,D[2]; cols = :union)
                        append!(DecoyDF,D[3]; cols = :union)

                    Engineering = findElement(s,"Engineering")
                    eR = EngineeringReport(Engineering)
                    insertcols!(eR,1,:shipKey => fill(shipKey,size(eR,1)))
                    append!(EngineeringDF,eR)
            end
        end
    end
    return shipdf, partStatusDf, EngagementHistDF, AntiShipDF, StrikeDF, SensorsDF, SensorsHighLevelDF,PointDefenceDF,AmmDF,DecoyDF,EngineeringDF

end

function matchReport2(_filename)
    # try 
        # fn = @raw_str(_filename)
        if size(readlines(_filename),1) == 2
            # parse(Node, str)
            doc = parse(Node,readlines(_filename)[2])

        elseif size(readlines(_filename),1) > 1

            doc = read(_filename, Node)

        end

        FullAfterActionReport = findElement(doc,"FullAfterActionReport")

        # get the match info and gameKey
        mi =  matchInfo(FullAfterActionReport)
        gameKey = mi[1]

        # ok so get teams
        Teams = findElement(FullAfterActionReport,"Teams")
        ti = teamInfo(Teams,gameKey)

        # and get the ship infomation
        si = shipInfo(findElement(FullAfterActionReport,"Teams"))
 
        return (mi[2],ti,si...)

    # catch e
    #     println(_filename)
    #     println("Error parsing file")
    # end

end


# ok so lets begin

localPath = "BattleReports"
savePath = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\Nebulous\\Saves\\SkirmishReports"
saves = readdir(savePath)

savesLocal = joinpath.(savePath,readdir(savePath))
# savesLocal = string.(savePath,"/",readdir(savePath))
savesKillboard = joinpath.(localPath,readdir(localPath))

allSaves = vcat(
    savesLocal,
    savesKillboard,
)

allSaves
AllDataArray = []

@showprogress for i in allSaves
    try
        x = matchReport2(i)
        if !isnothing(x)
            push!(AllDataArray, x)
        end
    catch e 
        println(i)
    end
end
AllDataArray

# "C:\Program Files (x86)\Steam\steamapps\common\Nebulous\Saves\SkirmishReports\Skirmish Report - MP - 30-Jul-2023 09-48-43.xml"

matchReport2(savesLocal[3])

function getDf(a,n)
    df = DataFrame()
        dfs = getNth.(a,n)
        for i in dfs
            append!(df,i,cols = :union,promote=true)
        end
    return df 
end

# this creates the whole table from the single ones
AllMatchReports = getDf(AllDataArray,1)
AllTeamReports = getDf(AllDataArray,2)
AllShipReports = getDf(AllDataArray,3)
AllPartReports = getDf(AllDataArray,4)
AllEngagementReports = getDf(AllDataArray,5)
AllWeaponReports = getDf(AllDataArray,6)
AllMissileReports = getDf(AllDataArray,7)
AllEwarReports = getDf(AllDataArray,8)
AllSensorsReport = getDf(AllDataArray,9)
AllPdReports = getDf(AllDataArray,10)
AllAmmReports = getDf(AllDataArray,11)
AllDecoyReports = getDf(AllDataArray,12)
AllEngineeringReports = getDf(AllDataArray,13)
# AllEngineeringReports = getDf(AllDataArray,14)


AllReports = (
    AllMatchReports,
    AllTeamReports,
    AllShipReports,
    AllPartReports,
    AllEngagementReports,
    AllWeaponReports,
    AllMissileReports,
    AllEwarReports,
    AllSensorsReport,
    AllPdReports,
    AllAmmReports,
    AllDecoyReports,
    AllEngineeringReports,
)

size(AllReports,1)

jldsave("AllReports.jld2";df = AllReports)

load_object("AllReports.jld2")
# x[1]
