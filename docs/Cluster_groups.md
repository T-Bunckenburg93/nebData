# Cluster Info on 81 clusters

Here I'm doing a clustering analysis to build on the point distributon analysis I did initally. 
The most common response, and my thoughts while I was building it, was that point cost is not a simple indication of ship build, and thus outcome. So I've spent a bit of time refining it, primarily by adding a bunch of components into the mix. 

Ive tried to build a model that both accomodates common builds, but also includes more niche builds that do show up. 
This has led to some overlap, and prossibly some differential of clusters that doesn't really exist, as well as lots of clusters ( 81 ), but I do feel/hope that this is reasonable representative of the ships rolls that you can see in Nebulous.

## Description of the tables:

### Hull Counts
Hull count shuld be pretty obvious. Generally there is one, but often there is overlap 


### Components
Here I tried to identify the specific componenets that made up a cluster. 
* meanVal, is the average number of that value that you would expect to see on this rype of hull. 
* proportion, is the proportion of this component that is in this cluster. for example, the first group contains about 50% of all S1/rockets
* scaledProportion, is this, but scaled by the size of the cluster, to make this number more meaningful for smaller clusters. if you had a component 50% of the time, and the size of the cluster was 10% of all ships, this number would be 5

### Exemplar
Each cluster is focused around a single ship that serves at the exemplar. This is the hull/components that this exemplar had.

### Hull Outcome vs WinRate
Counts and Percentages of wins and losses vs the ship being eliminated or not. Ideally this should show if the cluster is effective or not.



Now I'm not going to do a writeup of each one, as there are 81, but I do hope this is interesting. I will be using these clusters in the future to try and group fleet types, as I feel there is a lot of interesting things to unpack there.

Enjoy, and let me know what you think!

## Cluster 1, 4180 hulls

### Hull Counts

┌─────────────────────────┬───────┐
│                   Hulls │ Count │
├─────────────────────────┼───────┤
│           Stock/Shuttle │  1677 │
│ Stock/Sprinter Corvette │  1282 │
│           Stock/Tugboat │  1040 │
│       Stock/Bulk Feeder │   181 │
└─────────────────────────┴───────┘


### Components

┌─────────────────────────────┬────────────┬────────────┬──────────────────┐
│                       Names │    meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼────────────┼────────────┼──────────────────┤
│         MIS-Stock/S1 Rocket │    11.4428 │   0.533495 │           3.9522 │
│        MIS-Stock/SGM-1 Body │    4.77249 │   0.364712 │          2.70183 │
│                  PD-Jammers │  0.0488038 │   0.219355 │          1.62501 │
│                EWAR-Jammers │   0.491388 │    0.20088 │          1.48815 │
│       MIS-Stock/S3 Net Mine │   0.160287 │    0.18301 │          1.35576 │
│  DEC-Stock/EA12 Chaff Decoy │    2.91627 │   0.131781 │         0.976251 │
│  DEC-Stock/EA20 Flare Decoy │    0.96866 │   0.130487 │         0.966662 │
│    MIS-Stock/S3 Sprint Mine │   0.301196 │    0.12666 │         0.938314 │
│        PD-P11 'Pavise' PDT  │   0.223684 │   0.124352 │         0.921214 │
│         PD-P60 'Grazer' PDT │   0.169378 │   0.118772 │         0.879879 │
│           EWAR-Illuminators │  0.0411483 │  0.0948181 │         0.702425 │
│ DEC-Stock/EA99 Active Decoy │   0.282536 │  0.0841828 │         0.623637 │
│             EWAR-Omnijammer │  0.0239234 │  0.0794913 │         0.588882 │
│                 PD-&lt;line │ 0.00143541 │  0.0731707 │         0.542059 │
│       PD-P20 'Bastion' PDT  │   0.188517 │  0.0667514 │         0.494503 │
└─────────────────────────────┴────────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬───────────────┐
│                   variable │         value │
├────────────────────────────┼───────────────┤
│                    hullKey │ Stock/Tugboat │
│          OriginalPointCost │           339 │
│       MIS-Stock/SGM-1 Body │             6 │
│               EWAR-Jammers │             1 │
│        PD-P60 'Grazer' PDT │             1 │
│ DEC-Stock/EA12 Chaff Decoy │             5 │
│ DEC-Stock/EA20 Flare Decoy │             3 │
│             DCTeamsCarried │             1 │
└────────────────────────────┴───────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬──────┬────────┬─────────┐
│      Eliminated │  Win │ Loss │ WinPct │ LossPct │
├─────────────────┼──────┼──────┼────────┼─────────┤
│   NotEliminated │ 1468 │  327 │  0.352 │   0.078 │
│ Destroyed/Other │  957 │ 1423 │  0.229 │   0.341 │
│           Total │ 2425 │ 1750 │  0.581 │   0.419 │
└─────────────────┴──────┴──────┴────────┴─────────┘


## Cluster 2, 2659 hulls

### Hull Counts

┌─────────────────────────┬───────┐
│                   Hulls │ Count │
├─────────────────────────┼───────┤
│           Stock/Shuttle │  1450 │
│ Stock/Sprinter Corvette │   607 │
│           Stock/Tugboat │   598 │
│       Stock/Bulk Feeder │     4 │
└─────────────────────────┴───────┘


### Components

┌────────────────────────────┬───────────┬────────────┬──────────────────┐
│                      Names │   meanVal │ proportion │ scaledProportion │
├────────────────────────────┼───────────┼────────────┼──────────────────┤
│        MIS-Stock/S1 Rocket │   4.59045 │   0.136143 │          1.58548 │
│      MIS-Stock/S3 Net Mine │   0.16886 │   0.122644 │          1.42828 │
│          EWAR-Illuminators │ 0.0361038 │  0.0529217 │         0.616312 │
│       PD-P11 'Pavise' PDT  │  0.134261 │  0.0474797 │         0.552936 │
│ DEC-Stock/EA12 Chaff Decoy │   1.53592 │  0.0441504 │         0.514164 │
│                 PD-Jammers │ 0.0131628 │  0.0376344 │          0.43828 │
│ DEC-Stock/EA20 Flare Decoy │  0.436254 │  0.0373832 │         0.435354 │
│      PD-P20 'Bastion' PDT  │  0.163219 │  0.0367641 │         0.428145 │
│       MIS-Stock/SGM-1 Body │  0.734111 │  0.0356869 │           0.4156 │
│   MIS-Stock/S3 Sprint Mine │  0.125235 │   0.033501 │         0.390144 │
│               EWAR-Jammers │  0.106055 │  0.0275795 │         0.321183 │
│        PD-P60 'Grazer' PDT │ 0.0496427 │  0.0221439 │         0.257882 │
│          OriginalPointCost │   195.314 │  0.0201207 │         0.234321 │
│          MIS-Stock/S3 Mine │ 0.0312147 │  0.0192263 │         0.223904 │
└────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬─────────────────────────┐
│                   variable │                   value │
├────────────────────────────┼─────────────────────────┤
│                    hullKey │ Stock/Sprinter Corvette │
│          OriginalPointCost │                     185 │
│       MIS-Stock/SGM-1 Body │                       6 │
│ DEC-Stock/EA12 Chaff Decoy │                       2 │
│ DEC-Stock/EA20 Flare Decoy │                       1 │
│             DCTeamsCarried │                       1 │
└────────────────────────────┴─────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬──────┬────────┬─────────┐
│      Eliminated │  Win │ Loss │ WinPct │ LossPct │
├─────────────────┼──────┼──────┼────────┼─────────┤
│   NotEliminated │  760 │  186 │  0.286 │    0.07 │
│ Destroyed/Other │  754 │  959 │  0.284 │   0.361 │
│           Total │ 1514 │ 1145 │  0.569 │   0.431 │
└─────────────────┴──────┴──────┴────────┴─────────┘


## Cluster 3, 1550 hulls

### Hull Counts

┌──────────────────────┬───────┐
│                Hulls │ Count │
├──────────────────────┼───────┤
│ Stock/Raines Frigate │  1526 │
│    Stock/Bulk Hauler │    24 │
└──────────────────────┴───────┘


### Components

┌─────────────────────────────┬────────────┬────────────┬──────────────────┐
│                       Names │    meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼────────────┼────────────┼──────────────────┤
│                EWAR-Jammers │    1.25613 │   0.190416 │          3.80414 │
│      PD-Mk95 'Sarissa' PDT  │   0.460645 │   0.148533 │          2.96741 │
│           EWAR-Illuminators │   0.145806 │   0.124587 │            2.489 │
│                 PD-&lt;line │ 0.00516129 │   0.097561 │          1.94908 │
│        MIS-Stock/SGM-1 Body │    2.52839 │   0.071648 │          1.43139 │
│      MIS-Stock/SGM-H-3 Body │    1.15355 │  0.0703992 │          1.40644 │
│ DEC-Stock/EA99 Active Decoy │   0.445161 │  0.0491838 │         0.982598 │
│    PD-Mk29 'Stonewall' PDT  │   0.250323 │  0.0434783 │         0.868612 │
│        MIS-Stock/SGM-2 Body │    4.18065 │  0.0386526 │         0.772205 │
│  DEC-Stock/EA20 Flare Decoy │   0.749677 │  0.0374476 │         0.748131 │
│        MIS-Stock/SGT-3 Body │   0.267097 │  0.0318682 │         0.636665 │
│             EWAR-Omnijammer │  0.0258065 │  0.0317965 │         0.635233 │
│           OriginalPointCost │    464.401 │  0.0278879 │         0.557147 │
│              DCTeamsCarried │    2.05806 │  0.0262137 │         0.523699 │
└─────────────────────────────┴────────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────┐
│                 variable │                value │
├──────────────────────────┼──────────────────────┤
│                  hullKey │ Stock/Raines Frigate │
│        OriginalPointCost │                  438 │
│             EWAR-Jammers │                    1 │
│ PD-Mk29 'Stonewall' PDT  │                    1 │
│            RestoresTotal │                    1 │
│           DCTeamsCarried │                    2 │
└──────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │ 544 │  192 │  0.351 │   0.124 │
│ Destroyed/Other │ 231 │  583 │  0.149 │   0.376 │
│           Total │ 775 │  775 │    0.5 │     0.5 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 4, 1228 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│     Stock/Tugboat │  1198 │
│ Stock/Bulk Feeder │    30 │
└───────────────────┴───────┘


### Components

┌────────────────────────────┬───────────┬────────────┬──────────────────┐
│                      Names │   meanVal │ proportion │ scaledProportion │
├────────────────────────────┼───────────┼────────────┼──────────────────┤
│       WEAP-250mm Casemate  │   364.236 │   0.224311 │          5.65636 │
│                PD-&lt;line │ 0.0114007 │   0.170732 │          4.30528 │
│        PD-P60 'Grazer' PDT │  0.526059 │   0.108371 │          2.73275 │
│      PD-P20 'Bastion' PDT  │   0.87785 │  0.0913172 │          2.30271 │
│                 PD-Jammers │ 0.0488599 │  0.0645161 │          1.62688 │
│               EWAR-Jammers │  0.493485 │  0.0592665 │           1.4945 │
│       PD-P11 'Pavise' PDT  │  0.349349 │  0.0570555 │          1.43875 │
│        MIS-Stock/S1 Rocket │    4.0228 │  0.0550995 │          1.38942 │
│          EWAR-Illuminators │ 0.0675896 │  0.0457552 │          1.15379 │
│       MIS-Stock/SGM-2 Body │   5.61889 │  0.0411579 │          1.03786 │
│       MIS-Stock/SGT-3 Body │  0.330619 │  0.0312524 │          0.78808 │
│ DEC-Stock/EA12 Chaff Decoy │   1.64495 │  0.0218374 │         0.550664 │
│             DCTeamsCarried │   2.13762 │  0.0215709 │         0.543944 │
│ DEC-Stock/EA20 Flare Decoy │  0.459283 │   0.018176 │         0.458336 │
│       MIS-Stock/SGM-1 Body │  0.769544 │  0.0172767 │         0.435659 │
└────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────┐
│              variable │         value │
├───────────────────────┼───────────────┤
│               hullKey │ Stock/Tugboat │
│     OriginalPointCost │           377 │
│  WEAP-250mm Casemate  │           350 │
│  MIS-Stock/SGM-2 Body │             9 │
│          EWAR-Jammers │             1 │
│ PD-P20 'Bastion' PDT  │             2 │
│         RestoresTotal │             1 │
│        DCTeamsCarried │             2 │
└───────────────────────┴───────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  423 │ 194 │  0.158 │   0.344 │
│   NotEliminated │  115 │ 496 │  0.404 │   0.094 │
│           Total │  690 │ 538 │  0.438 │   0.562 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 5, 1195 hulls

### Hull Counts

┌─────────────────────────┬───────┐
│                   Hulls │ Count │
├─────────────────────────┼───────┤
│       Stock/Bulk Feeder │   929 │
│ Stock/Sprinter Corvette │   147 │
│           Stock/Tugboat │   110 │
│           Stock/Shuttle │     9 │
└─────────────────────────┴───────┘


### Components

┌──────────────────────────┬───────────┬────────────┬──────────────────┐
│                    Names │   meanVal │ proportion │ scaledProportion │
├──────────────────────────┼───────────┼────────────┼──────────────────┤
│     MIS-Stock/SGT-3 Body │   1.78075 │   0.163806 │          4.24469 │
│   WEAP-TE45 Mass Driver  │   58.2335 │   0.162364 │          4.20733 │
│ MIS-Stock/S3 Sprint Mine │   0.69205 │  0.0831992 │          2.15594 │
│        EWAR-Illuminators │  0.119665 │  0.0788313 │          2.04275 │
│       WEAP-400mm Plasma  │   37.4577 │  0.0694347 │          1.79926 │
│      PD-P60 'Grazer' PDT │  0.340586 │  0.0682771 │          1.76926 │
│     MIS-Stock/SGM-2 Body │   9.13222 │  0.0650951 │          1.68681 │
│    PD-P20 'Bastion' PDT  │  0.607531 │  0.0614994 │          1.59363 │
│     PD-P11 'Pavise' PDT  │  0.380753 │  0.0605134 │          1.56808 │
│      MIS-Stock/S1 Rocket │   4.39163 │  0.0585348 │          1.51681 │
│        MIS-Stock/S3 Mine │  0.203347 │  0.0562891 │          1.45862 │
│               PD-Jammers │ 0.0426778 │  0.0548387 │          1.42103 │
│    MIS-Stock/S3 Net Mine │  0.108787 │  0.0355094 │         0.920155 │
│     MIS-Stock/SGM-1 Body │   1.56234 │  0.0341329 │         0.884484 │
│            RestoresTotal │   1.96653 │   0.032738 │         0.848339 │
└──────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬───────────────────┐
│               variable │             value │
├────────────────────────┼───────────────────┤
│                hullKey │ Stock/Bulk Feeder │
│      OriginalPointCost │               582 │
│ WEAP-TE45 Mass Driver  │                50 │
│  PD-P20 'Bastion' PDT  │                 2 │
│          RestoresTotal │                 7 │
│         DCTeamsCarried │                 5 │
└────────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  426 │ 169 │  0.142 │   0.357 │
│   NotEliminated │  161 │ 436 │  0.366 │   0.135 │
│           Total │  605 │ 587 │  0.492 │   0.508 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 6, 1099 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│       Stock/Ocello Cruiser │   798 │
│ Stock/Axford Heavy Cruiser │   301 │
└────────────────────────────┴───────┘


### Components

┌────────────────────────────┬──────────┬────────────┬──────────────────┐
│                      Names │  meanVal │ proportion │ scaledProportion │
├────────────────────────────┼──────────┼────────────┼──────────────────┤
│            EWAR-Omnijammer │ 0.435851 │   0.380763 │          10.7286 │
│       PD-Mk90 'Aurora' PDT │  1.06005 │   0.286663 │          8.07718 │
│     PD-Mk95 'Sarissa' PDT  │  1.25296 │   0.286457 │          8.07137 │
│            WEAP-450mm Gun  │  561.178 │   0.265456 │          7.47963 │
│                 PD-Jammers │ 0.199272 │   0.235484 │          6.63512 │
│   PD-Mk29 'Stonewall' PDT  │  0.77707 │   0.095697 │          2.69641 │
│          EWAR-Illuminators │ 0.151046 │  0.0915105 │          2.57845 │
│             DCTeamsCarried │  8.24113 │  0.0744256 │          2.09705 │
│               EWAR-Jammers │  0.66697 │   0.071687 │          2.01989 │
│     PD-Mk25 'Rebound' PDT  │ 0.461328 │   0.071318 │          2.00949 │
│ DEC-Stock/EA12 Chaff Decoy │    5.899 │   0.070085 │          1.97475 │
│              RestoresTotal │  4.44495 │  0.0680533 │           1.9175 │
│          OriginalPointCost │  1565.42 │  0.0666529 │          1.87805 │
│ DEC-Stock/EA20 Flare Decoy │   1.7252 │  0.0611022 │          1.72165 │
└────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬────────────────────────────┐
│                   variable │                      value │
├────────────────────────────┼────────────────────────────┤
│                    hullKey │ Stock/Axford Heavy Cruiser │
│          OriginalPointCost │                       1565 │
│            WEAP-450mm Gun  │                        533 │
│    PD-Mk20 'Defender' PDT  │                          2 │
│   PD-Mk29 'Stonewall' PDT  │                          2 │
│       PD-Mk90 'Aurora' PDT │                          2 │
│ DEC-Stock/EA12 Chaff Decoy │                          7 │
│              RestoresTotal │                          5 │
│             DCTeamsCarried │                          9 │
└────────────────────────────┴────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  343 │ 105 │  0.096 │   0.312 │
│   NotEliminated │  182 │ 469 │  0.427 │   0.166 │
│           Total │  574 │ 525 │  0.478 │   0.522 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 7, 862 hulls

### Hull Counts

┌─────────────────────────┬───────┐
│                   Hulls │ Count │
├─────────────────────────┼───────┤
│ Stock/Sprinter Corvette │   862 │
└─────────────────────────┴───────┘


### Components

┌────────────────────────────┬────────────┬────────────┬──────────────────┐
│                      Names │    meanVal │ proportion │ scaledProportion │
├────────────────────────────┼────────────┼────────────┼──────────────────┤
│              PD-120mm Gun  │     1.1891 │    0.15796 │          5.67445 │
│            WEAP-120mm Gun  │    501.365 │   0.107445 │          3.85979 │
│    PD-Mk20 'Defender' PDT  │    1.25754 │  0.0551822 │          1.98234 │
│       MIS-Stock/SGT-3 Body │   0.558005 │  0.0370256 │          1.33009 │
│     PD-Mk25 'Rebound' PDT  │   0.265661 │  0.0322127 │          1.15719 │
│     MIS-Stock/SGM-H-3 Body │   0.853828 │  0.0289787 │          1.04101 │
│                PD-&lt;line │ 0.00232019 │  0.0243902 │         0.876181 │
│       MIS-Stock/SGM-1 Body │        1.5 │  0.0236389 │          0.84919 │
│ DEC-Stock/EA12 Chaff Decoy │    1.66009 │  0.0154699 │         0.555733 │
│     MIS-Stock/SGM-H-2 Body │   0.540603 │  0.0108211 │         0.388731 │
│          OriginalPointCost │    316.669 │  0.0105756 │         0.379911 │
│             DCTeamsCarried │    1.37703 │ 0.00975413 │         0.350402 │
│ DEC-Stock/EA20 Flare Decoy │   0.350348 │ 0.00973252 │         0.349625 │
│               EWAR-Jammers │   0.112529 │ 0.00948655 │          0.34079 │
└────────────────────────────┴────────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬─────────────────────────┐
│                variable │                   value │
├─────────────────────────┼─────────────────────────┤
│                 hullKey │ Stock/Sprinter Corvette │
│       OriginalPointCost │                     302 │
│         WEAP-120mm Gun  │                     450 │
│           PD-120mm Gun  │                       1 │
│  PD-Mk25 'Rebound' PDT  │                       2 │
│ PD-Mk20 'Defender' PDT  │                       1 │
│           RestoresTotal │                       2 │
│          DCTeamsCarried │                       3 │
└─────────────────────────┴─────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │ 222 │  334 │  0.258 │   0.387 │
│   NotEliminated │ 282 │   24 │  0.327 │   0.028 │
│           Total │ 504 │  358 │  0.585 │   0.415 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 8, 732 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│     Stock/Shuttle │   600 │
│     Stock/Tugboat │   123 │
│ Stock/Bulk Feeder │     9 │
└───────────────────┴───────┘


### Components

┌────────────────────────────┬───────────┬────────────┬──────────────────┐
│                      Names │   meanVal │ proportion │ scaledProportion │
├────────────────────────────┼───────────┼────────────┼──────────────────┤
│              PD-100mm Gun  │  0.758197 │   0.128383 │          5.43102 │
│            WEAP-100mm Gun  │   444.701 │  0.0463815 │          1.96209 │
│      MIS-Stock/S3 Net Mine │  0.219945 │  0.0439771 │          1.86037 │
│        MIS-Stock/S1 Rocket │   5.05464 │  0.0412688 │          1.74581 │
│       PD-P11 'Pavise' PDT  │  0.277322 │  0.0269983 │          1.14212 │
│   MIS-Stock/S3 Sprint Mine │  0.336066 │  0.0247485 │          1.04694 │
│          MIS-Stock/S3 Mine │  0.102459 │  0.0173732 │         0.734942 │
│       MIS-Stock/SGM-1 Body │   1.26913 │  0.0169842 │         0.718486 │
│      PD-P20 'Bastion' PDT  │  0.210383 │  0.0130453 │          0.55186 │
│        PD-P60 'Grazer' PDT │ 0.0997268 │  0.0122463 │         0.518057 │
│ DEC-Stock/EA12 Chaff Decoy │    1.4194 │  0.0112322 │         0.475158 │
│ DEC-Stock/EA20 Flare Decoy │  0.385246 │ 0.00908798 │         0.384451 │
│             DCTeamsCarried │   1.35109 │ 0.00812707 │         0.343802 │
│          OriginalPointCost │   233.757 │ 0.00662928 │          0.28044 │
└────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────┬───────────────┐
│          variable │         value │
├───────────────────┼───────────────┤
│           hullKey │ Stock/Tugboat │
│ OriginalPointCost │           249 │
│   WEAP-100mm Gun  │           400 │
│    DCTeamsCarried │             1 │
└───────────────────┴───────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  276 │ 208 │  0.284 │   0.377 │
│   NotEliminated │   29 │ 219 │  0.299 │    0.04 │
│           Total │  427 │ 305 │  0.417 │   0.583 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 9, 729 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Keystone Destroyer │   729 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│         WEAP-Mk550 Railgun  │  148.232 │   0.619275 │          26.3052 │
│      WEAP-Mk600 Beam Cannon │ 0.310014 │   0.158819 │          6.74623 │
│      PD-Mk25 'Rebound' PDT  │ 0.791495 │  0.0811647 │          3.44766 │
│     PD-Mk20 'Defender' PDT  │  1.16049 │  0.0430666 │          1.82936 │
│      PD-Mk95 'Sarissa' PDT  │ 0.155007 │  0.0235074 │         0.998532 │
│    PD-Mk29 'Stonewall' PDT  │ 0.249657 │  0.0203944 │         0.866302 │
│ DEC-Stock/EA99 Active Decoy │ 0.390947 │  0.0203151 │          0.86293 │
│  DEC-Stock/EA12 Chaff Decoy │  2.32647 │  0.0183347 │         0.778811 │
│                EWAR-Jammers │ 0.249657 │  0.0177995 │         0.756076 │
│  DEC-Stock/EA20 Flare Decoy │ 0.676269 │  0.0158879 │         0.674874 │
│           OriginalPointCost │  561.466 │  0.0158578 │         0.673597 │
│              DCTeamsCarried │  2.58573 │  0.0154899 │         0.657971 │
│               PD-120mm Gun  │ 0.131687 │  0.0147943 │         0.628422 │
│               RestoresTotal │  1.15775 │  0.0117578 │         0.499441 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────────┐
│                 variable │                    value │
├──────────────────────────┼──────────────────────────┤
│                  hullKey │ Stock/Keystone Destroyer │
│        OriginalPointCost │                      620 │
│      WEAP-Mk550 Railgun  │                      125 │
│   PD-Mk25 'Rebound' PDT  │                        1 │
│  PD-Mk20 'Defender' PDT  │                        3 │
│ PD-Mk29 'Stonewall' PDT  │                        2 │
└──────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  259 │  79 │  0.108 │   0.355 │
│   NotEliminated │  100 │ 291 │  0.399 │   0.137 │
│           Total │  370 │ 359 │  0.492 │   0.508 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 10, 677 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Keystone Destroyer │   677 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│      WEAP-Mk600 Beam Cannon │  0.85229 │   0.405481 │          18.5467 │
│      MIS-Stock/SGM-H-3 Body │  3.52437 │  0.0939444 │          4.29702 │
│    PD-Mk29 'Stonewall' PDT  │  1.10487 │  0.0838189 │          3.83388 │
│         WEAP-Mk550 Railgun  │  15.6484 │   0.060712 │          2.77697 │
│     PD-Mk20 'Defender' PDT  │  1.37075 │  0.0472409 │           2.1608 │
│ DEC-Stock/EA99 Active Decoy │ 0.864106 │  0.0416993 │          1.90733 │
│                EWAR-Jammers │ 0.506647 │  0.0335452 │          1.53436 │
│        MIS-Stock/SGM-1 Body │  2.41359 │  0.0298731 │           1.3664 │
│        PD-Mk90 'Aurora' PDT │ 0.174298 │  0.0290354 │          1.32808 │
│      PD-Mk95 'Sarissa' PDT  │ 0.197932 │   0.027876 │          1.27505 │
│              DCTeamsCarried │  4.80945 │  0.0267561 │          1.22382 │
│  DEC-Stock/EA20 Flare Decoy │  1.12703 │  0.0245891 │          1.12471 │
│      PD-Mk25 'Rebound' PDT  │ 0.252585 │   0.024054 │          1.10023 │
│      MIS-Stock/SGM-H-2 Body │  1.47563 │   0.023198 │          1.06108 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────────┐
│                 variable │                    value │
├──────────────────────────┼──────────────────────────┤
│                  hullKey │ Stock/Keystone Destroyer │
│        OriginalPointCost │                      845 │
│   WEAP-Mk600 Beam Cannon │                        1 │
│   PD-Mk25 'Rebound' PDT  │                        2 │
│  PD-Mk20 'Defender' PDT  │                        2 │
│ PD-Mk29 'Stonewall' PDT  │                        2 │
│            RestoresTotal │                        3 │
│           DCTeamsCarried │                        6 │
└──────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  265 │ 104 │  0.154 │   0.391 │
│   NotEliminated │   73 │ 235 │  0.347 │   0.108 │
│           Total │  339 │ 338 │  0.499 │   0.501 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 11, 566 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │   566 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│               PD-250mm Gun  │   4.68905 │   0.269551 │          14.7472 │
│             WEAP-250mm Gun  │   1583.78 │   0.184339 │          10.0852 │
│     PD-Mk20 'Defender' PDT  │   2.60777 │  0.0751374 │          4.11079 │
│      PD-Mk25 'Rebound' PDT  │  0.913428 │  0.0727247 │          3.97879 │
│ DEC-Stock/EA99 Active Decoy │   1.23145 │  0.0496828 │          2.71816 │
│              DCTeamsCarried │   7.72792 │  0.0359432 │          1.96646 │
│      MIS-Stock/SGM-H-3 Body │   1.44876 │   0.032286 │          1.76638 │
│               RestoresTotal │   3.92226 │   0.030927 │          1.69202 │
│  DEC-Stock/EA20 Flare Decoy │   1.31625 │   0.024009 │          1.31354 │
│           OriginalPointCost │   1093.12 │  0.0239704 │          1.31143 │
│  DEC-Stock/EA12 Chaff Decoy │   3.89576 │  0.0238373 │          1.30415 │
│      MIS-Stock/SGM-H-2 Body │   1.68198 │  0.0221066 │          1.20946 │
│           EWAR-Illuminators │ 0.0565371 │  0.0176406 │          0.96512 │
│                EWAR-Jammers │  0.310954 │  0.0172127 │         0.941712 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────────────┐
│                variable │                        value │
├─────────────────────────┼──────────────────────────────┤
│                 hullKey │ Stock/Vauxhall Light Cruiser │
│       OriginalPointCost │                         1086 │
│         WEAP-250mm Gun  │                         1550 │
│  MIS-Stock/SGM-H-2 Body │                           10 │
│            EWAR-Jammers │                            1 │
│  PD-Mk25 'Rebound' PDT  │                            2 │
│ PD-Mk20 'Defender' PDT  │                            2 │
│           PD-250mm Gun  │                            4 │
│           RestoresTotal │                            2 │
│          DCTeamsCarried │                            4 │
└─────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  193 │  81 │  0.143 │   0.341 │
│   NotEliminated │   79 │ 213 │  0.376 │    0.14 │
│           Total │  294 │ 272 │  0.481 │   0.519 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 12, 551 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │   551 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬────────────┬────────────┬──────────────────┐
│                                 Names │    meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼────────────┼────────────┼──────────────────┤
│                  WEAP-450mm Casemate  │    624.372 │   0.303029 │          17.0301 │
│                 PD-P20 'Bastion' PDT  │    2.10163 │   0.098094 │          5.51285 │
│                  PD-P11 'Pavise' PDT  │    1.25771 │  0.0921665 │          5.17972 │
│                   PD-P60 'Grazer' PDT │   0.635209 │   0.058715 │          3.29976 │
│              MIS-Stock/Mine Container │   0.606171 │  0.0516229 │          2.90119 │
│ MIS-Stock/Decoy Container (Line Ship) │   0.192377 │  0.0445753 │          2.50511 │
│                            PD-Jammers │  0.0725953 │  0.0430108 │          2.41719 │
│                         RestoresTotal │    5.19601 │  0.0398847 │           2.2415 │
│                           PD-&lt;line │ 0.00544465 │  0.0365854 │          2.05608 │
│                        DCTeamsCarried │    5.89111 │  0.0266739 │          1.49906 │
│            MIS-Stock/Rocket Container │   0.333938 │   0.025974 │          1.45973 │
│   MIS-Stock/Decoy Container (Clipper) │   0.103448 │   0.025722 │          1.44557 │
│            DEC-Stock/EA20 Flare Decoy │    1.24138 │  0.0220432 │          1.23882 │
│                     OriginalPointCost │    1005.68 │  0.0214686 │          1.20653 │
│            DEC-Stock/EA12 Chaff Decoy │    3.36116 │  0.0200212 │          1.12518 │
└───────────────────────────────────────┴────────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────┬───────────────────┐
│             variable │             value │
├──────────────────────┼───────────────────┤
│              hullKey │ Stock/Bulk Hauler │
│    OriginalPointCost │              1072 │
│ WEAP-450mm Casemate  │               650 │
│         EWAR-Jammers │                 1 │
│ PD-P11 'Pavise' PDT  │                 5 │
│        RestoresTotal │                14 │
│       DCTeamsCarried │                 4 │
└──────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │ 233 │   81 │  0.423 │   0.147 │
│ Destroyed/Other │  62 │  175 │  0.113 │   0.318 │
│           Total │ 295 │  256 │  0.535 │   0.465 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 13, 544 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│       Stock/Ocello Cruiser │   409 │
│ Stock/Axford Heavy Cruiser │   135 │
└────────────────────────────┴───────┘


### Components

┌────────────────────────────┬───────────┬────────────┬──────────────────┐
│                      Names │   meanVal │ proportion │ scaledProportion │
├────────────────────────────┼───────────┼────────────┼──────────────────┤
│            WEAP-450mm Gun  │   503.439 │    0.11788 │          6.71006 │
│       PD-Mk90 'Aurora' PDT │  0.779412 │   0.104331 │           5.9388 │
│     PD-Mk95 'Sarissa' PDT  │  0.689338 │  0.0780112 │          4.44062 │
│           WEAP-Beam Turret │ 0.0845588 │  0.0624152 │          3.55285 │
│   PD-Mk29 'Stonewall' PDT  │  0.882353 │  0.0537875 │          3.06174 │
│          EWAR-Illuminators │  0.152574 │  0.0457552 │          2.60452 │
│ DEC-Stock/EA12 Chaff Decoy │   7.06801 │  0.0415667 │          2.36609 │
│                 PD-Jammers │ 0.0698529 │  0.0408602 │          2.32588 │
│            EWAR-Omnijammer │ 0.0900735 │  0.0389507 │          2.21718 │
│ DEC-Stock/EA20 Flare Decoy │   2.18382 │  0.0382855 │          2.17932 │
│    PD-Mk20 'Defender' PDT  │   1.24265 │  0.0344125 │          1.95886 │
│     PD-Mk25 'Rebound' PDT  │  0.408088 │   0.031228 │          1.77759 │
│             DCTeamsCarried │   6.96507 │   0.031136 │          1.77235 │
│          OriginalPointCost │   1397.57 │  0.0294554 │          1.67668 │
└────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬──────────────────────┐
│                   variable │                value │
├────────────────────────────┼──────────────────────┤
│                    hullKey │ Stock/Ocello Cruiser │
│          OriginalPointCost │                 1426 │
│            WEAP-450mm Gun  │                  500 │
│               EWAR-Jammers │                    1 │
│    PD-Mk20 'Defender' PDT  │                    3 │
│   PD-Mk29 'Stonewall' PDT  │                    2 │
│ DEC-Stock/EA12 Chaff Decoy │                    8 │
│ DEC-Stock/EA20 Flare Decoy │                    4 │
│              RestoresTotal │                    4 │
│             DCTeamsCarried │                    9 │
└────────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  184 │  60 │   0.11 │   0.338 │
│   NotEliminated │   88 │ 212 │   0.39 │   0.162 │
│           Total │  272 │ 272 │    0.5 │     0.5 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 14, 542 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│     Stock/Shuttle │   254 │
│ Stock/Bulk Feeder │   216 │
│     Stock/Tugboat │    72 │
└───────────────────┴───────┘


### Components

┌────────────────────────────┬───────────┬────────────┬──────────────────┐
│                      Names │   meanVal │ proportion │ scaledProportion │
├────────────────────────────┼───────────┼────────────┼──────────────────┤
│              PD-100mm Gun  │  0.739852 │  0.0927597 │          5.29962 │
│            WEAP-100mm Gun  │   1021.32 │  0.0788725 │          4.50621 │
│         WEAP-400mm Plasma  │   53.6347 │  0.0450933 │          2.57631 │
│      PD-P20 'Bastion' PDT  │    0.5369 │  0.0246506 │          1.40836 │
│        MIS-Stock/S1 Rocket │   3.80074 │  0.0229767 │          1.31272 │
│       PD-P11 'Pavise' PDT  │  0.273063 │  0.0196835 │          1.12457 │
│        PD-P60 'Grazer' PDT │  0.210332 │  0.0191243 │          1.09263 │
│      MIS-Stock/S3 Net Mine │  0.129151 │  0.0191205 │          1.09241 │
│              RestoresTotal │   1.78229 │  0.0134574 │          0.76886 │
│             DCTeamsCarried │   2.68266 │  0.0119482 │         0.682634 │
│                 PD-Jammers │ 0.0202952 │   0.011828 │         0.675765 │
│   MIS-Stock/S3 Sprint Mine │  0.197417 │  0.0107646 │         0.615011 │
│          MIS-Stock/S3 Mine │ 0.0830258 │  0.0104239 │         0.595547 │
│ DEC-Stock/EA20 Flare Decoy │   0.49262 │ 0.00860458 │         0.491604 │
│       WEAP-450mm Casemate  │   16.6605 │ 0.00795385 │         0.454426 │
└────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────┐
│              variable │         value │
├───────────────────────┼───────────────┤
│               hullKey │ Stock/Tugboat │
│     OriginalPointCost │           343 │
│       WEAP-100mm Gun  │          1007 │
│ PD-P20 'Bastion' PDT  │             2 │
│        DCTeamsCarried │             1 │
└───────────────────────┴───────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │ 151 │   34 │  0.279 │   0.063 │
│ Destroyed/Other │ 120 │  237 │  0.221 │   0.437 │
│           Total │ 271 │  271 │    0.5 │     0.5 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 15, 537 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Feeder │   424 │
│     Stock/Shuttle │    76 │
│     Stock/Tugboat │    37 │
└───────────────────┴───────┘


### Components

┌────────────────────────────┬──────────┬────────────┬──────────────────┐
│                      Names │  meanVal │ proportion │ scaledProportion │
├────────────────────────────┼──────────┼────────────┼──────────────────┤
│            WEAP-100mm Gun  │  1631.12 │   0.124803 │          7.19674 │
│              PD-100mm Gun  │ 0.700186 │  0.0869766 │          5.01549 │
│         WEAP-400mm Plasma  │  93.6778 │   0.078033 │          4.49976 │
│          MIS-Stock/S3 Mine │ 0.513966 │  0.0639333 │           3.6867 │
│        PD-P60 'Grazer' PDT │ 0.409683 │  0.0369066 │          2.12821 │
│      PD-P20 'Bastion' PDT  │ 0.590317 │   0.026853 │          1.54847 │
│      MIS-Stock/S3 Net Mine │ 0.178771 │  0.0262223 │          1.51211 │
│       PD-P11 'Pavise' PDT  │  0.35568 │  0.0254023 │          1.46482 │
│              RestoresTotal │  2.79888 │  0.0209384 │          1.20741 │
│     WEAP-TE45 Mass Driver  │  13.8175 │  0.0173122 │         0.998306 │
│   MIS-Stock/S3 Sprint Mine │ 0.320298 │  0.0173038 │         0.997822 │
│             DCTeamsCarried │  3.83985 │  0.0169444 │         0.977096 │
│          OriginalPointCost │  521.594 │  0.0108517 │         0.625762 │
│        MIS-Stock/S1 Rocket │  1.64246 │  0.0098376 │         0.567283 │
│ DEC-Stock/EA20 Flare Decoy │ 0.549348 │ 0.00950693 │         0.548215 │
└────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────────┐
│              variable │             value │
├───────────────────────┼───────────────────┤
│               hullKey │ Stock/Bulk Feeder │
│     OriginalPointCost │               479 │
│       WEAP-100mm Gun  │              1600 │
│    WEAP-400mm Plasma  │               100 │
│ PD-P20 'Bastion' PDT  │                 1 │
│         PD-100mm Gun  │                 2 │
│         RestoresTotal │                 5 │
│        DCTeamsCarried │                 3 │
└───────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  167 │ 105 │  0.197 │   0.313 │
│   NotEliminated │   66 │ 195 │  0.366 │   0.124 │
│           Total │  300 │ 233 │  0.437 │   0.563 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 16, 519 hulls

### Hull Counts

┌──────────────────────┬───────┐
│                Hulls │ Count │
├──────────────────────┼───────┤
│ Stock/Raines Frigate │   397 │
│    Stock/Bulk Hauler │   122 │
└──────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│      MIS-Stock/SGM-H-2 Body │   13.5164 │   0.162897 │          9.71921 │
│      MIS-Stock/SGM-H-3 Body │   5.84778 │   0.119498 │          7.12979 │
│  DEC-Stock/EA12 Chaff Decoy │   8.57996 │  0.0481395 │          2.87223 │
│  DEC-Stock/EA20 Flare Decoy │   2.49133 │  0.0416694 │          2.48619 │
│      WEAP-TE45 Mass Driver  │   22.8902 │  0.0277182 │           1.6538 │
│ DEC-Stock/EA99 Active Decoy │  0.722543 │  0.0267303 │          1.59486 │
│        MIS-Stock/SGM-1 Body │   2.15029 │  0.0204029 │          1.21734 │
│           OriginalPointCost │   1002.74 │  0.0201627 │            1.203 │
│        MIS-Stock/SGM-2 Body │   5.59152 │  0.0173102 │          1.03281 │
│        PD-P11 'Pavise' PDT  │  0.217726 │  0.0150286 │         0.896677 │
│       PD-P20 'Bastion' PDT  │  0.287091 │  0.0126218 │         0.753075 │
│              DCTeamsCarried │   2.72832 │  0.0116359 │         0.694255 │
│               RestoresTotal │   1.30443 │ 0.00943133 │         0.562718 │
│           EWAR-Illuminators │ 0.0308285 │ 0.00882029 │          0.52626 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬──────────────────────┐
│                    variable │                value │
├─────────────────────────────┼──────────────────────┤
│                     hullKey │ Stock/Raines Frigate │
│           OriginalPointCost │                 1050 │
│      MIS-Stock/SGM-H-3 Body │                    6 │
│        MIS-Stock/SGM-1 Body │                    1 │
│      MIS-Stock/SGM-H-2 Body │                   18 │
│  DEC-Stock/EA12 Chaff Decoy │                    8 │
│  DEC-Stock/EA20 Flare Decoy │                    8 │
│ DEC-Stock/EA99 Active Decoy │                    2 │
│               RestoresTotal │                    2 │
│              DCTeamsCarried │                    4 │
└─────────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   71 │ 220 │  0.426 │   0.137 │
│ Destroyed/Other │  181 │  45 │  0.087 │    0.35 │
│           Total │  265 │ 252 │  0.487 │   0.513 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 17, 501 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│   Stock/Container Hauler │   346 │
│        Stock/Bulk Hauler │   149 │
│ Stock/Keystone Destroyer │     6 │
└──────────────────────────┴───────┘


### Components

┌───────────────────────────────────────┬──────────┬────────────┬──────────────────┐
│                                 Names │  meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼──────────┼────────────┼──────────────────┤
│                   MIS-Stock/CM-4 Body │  113.884 │   0.824044 │          50.9328 │
│              MIS-Stock/Mine Container │  8.40719 │   0.651005 │          40.2375 │
│            MIS-Stock/Rocket Container │  8.89421 │   0.629023 │          38.8789 │
│   MIS-Stock/Decoy Container (Clipper) │  2.75649 │   0.623195 │          38.5187 │
│ MIS-Stock/Decoy Container (Line Ship) │  1.48104 │   0.312027 │          19.2859 │
│                  MIS-Stock/SGM-2 Body │  62.3832 │   0.186427 │          11.5228 │
│                     MIS-Stock/S3 Mine │  1.16168 │   0.134816 │          8.33275 │
│                  MIS-Stock/SGT-3 Body │  2.59281 │  0.0999923 │          6.18036 │
│                 MIS-Stock/S3 Net Mine │  0.60479 │  0.0827643 │          5.11553 │
│                  PD-P11 'Pavise' PDT  │ 0.906188 │  0.0603804 │          3.73201 │
│                     OriginalPointCost │  2965.44 │  0.0575595 │          3.55766 │
│              MIS-Stock/S3 Sprint Mine │ 0.898204 │  0.0452716 │          2.79817 │
│                 PD-P20 'Bastion' PDT  │  1.03194 │   0.043795 │           2.7069 │
│                   PD-P60 'Grazer' PDT │ 0.508982 │  0.0427781 │          2.64404 │
│                  MIS-Stock/SGM-1 Body │  3.51098 │  0.0321584 │          1.98766 │
└───────────────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────┬────────────────────────┐
│            variable │                  value │
├─────────────────────┼────────────────────────┤
│             hullKey │ Stock/Container Hauler │
│   OriginalPointCost │                   2996 │
│ MIS-Stock/CM-4 Body │                    119 │
└─────────────────────┴────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   57 │ 165 │  0.329 │   0.114 │
│ Destroyed/Other │  215 │  64 │  0.128 │   0.429 │
│           Total │  229 │ 272 │  0.543 │   0.457 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 18, 471 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│       Stock/Ocello Cruiser │   243 │
│ Stock/Axford Heavy Cruiser │   228 │
└────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│             WEAP-450mm Gun  │    936.73 │   0.189902 │          12.4851 │
│        PD-Mk90 'Aurora' PDT │   0.59448 │  0.0688976 │          4.52969 │
│    PD-Mk29 'Stonewall' PDT  │   1.13163 │  0.0597266 │          3.92674 │
│      PD-Mk95 'Sarissa' PDT  │  0.602972 │  0.0590805 │          3.88426 │
│  DEC-Stock/EA12 Chaff Decoy │   7.94268 │  0.0404424 │          2.65889 │
│     PD-Mk20 'Defender' PDT  │   1.60085 │  0.0383832 │          2.52351 │
│           EWAR-Illuminators │  0.131635 │  0.0341786 │          2.24708 │
│             EWAR-Omnijammer │ 0.0870488 │  0.0325914 │          2.14273 │
│              DCTeamsCarried │   8.33333 │  0.0322536 │          2.12052 │
│               RestoresTotal │     4.862 │  0.0319021 │          2.09741 │
│           OriginalPointCost │   1551.76 │  0.0283164 │          1.86166 │
│      PD-Mk25 'Rebound' PDT  │  0.373673 │  0.0247573 │          1.62768 │
│ DEC-Stock/EA99 Active Decoy │  0.656051 │  0.0220258 │          1.44809 │
│  DEC-Stock/EA20 Flare Decoy │   1.28238 │   0.019465 │          1.27973 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬──────────────────────┐
│               variable │                value │
├────────────────────────┼──────────────────────┤
│                hullKey │ Stock/Ocello Cruiser │
│      OriginalPointCost │                 1551 │
│        WEAP-450mm Gun  │                  925 │
│           EWAR-Jammers │                    1 │
│ PD-Mk95 'Sarissa' PDT  │                    2 │
│  PD-P20 'Bastion' PDT  │                    4 │
│          RestoresTotal │                    3 │
│         DCTeamsCarried │                    7 │
└────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │ 178 │   77 │  0.383 │   0.166 │
│ Destroyed/Other │  44 │  166 │  0.095 │   0.357 │
│           Total │ 222 │  243 │  0.477 │   0.523 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 19, 470 hulls

### Hull Counts

┌─────────────────────────┬───────┐
│                   Hulls │ Count │
├─────────────────────────┼───────┤
│       Stock/Bulk Feeder │   463 │
│ Stock/Sprinter Corvette │     4 │
│           Stock/Tugboat │     3 │
└─────────────────────────┴───────┘


### Components

┌──────────────────────────┬──────────┬────────────┬──────────────────┐
│                    Names │  meanVal │ proportion │ scaledProportion │
├──────────────────────────┼──────────┼────────────┼──────────────────┤
│    MIS-Stock/S3 Net Mine │  1.88298 │   0.241737 │          15.9269 │
│     MIS-Stock/SGM-2 Body │  58.4553 │    0.16388 │          10.7973 │
│        MIS-Stock/S3 Mine │  1.22553 │   0.133426 │          8.79079 │
│ MIS-Stock/S3 Sprint Mine │  2.31702 │   0.109557 │           7.2182 │
│     MIS-Stock/SGT-3 Body │  2.58298 │  0.0934493 │          6.15692 │
│      MIS-Stock/S1 Rocket │  7.20851 │  0.0377889 │          2.48972 │
│     WEAP-250mm Casemate  │  109.734 │  0.0258648 │           1.7041 │
│      PD-P60 'Grazer' PDT │ 0.289362 │   0.022815 │          1.50317 │
│        OriginalPointCost │  946.143 │  0.0172284 │           1.1351 │
│            RestoresTotal │  2.59149 │   0.016968 │          1.11794 │
│     MIS-Stock/SGM-1 Body │  1.73191 │  0.0148817 │         0.980483 │
│           DCTeamsCarried │  3.26383 │  0.0126056 │         0.830521 │
│   WEAP-TE45 Mass Driver  │  10.7234 │  0.0117592 │         0.774759 │
│     WEAP-450mm Casemate  │  25.1064 │  0.0103937 │         0.684793 │
│     PD-P11 'Pavise' PDT  │ 0.159574 │ 0.00997473 │         0.657186 │
└──────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────┬───────────────────┐
│             variable │             value │
├──────────────────────┼───────────────────┤
│              hullKey │ Stock/Bulk Feeder │
│    OriginalPointCost │               951 │
│ WEAP-250mm Casemate  │                50 │
│ MIS-Stock/SGM-2 Body │                64 │
└──────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  141 │  84 │  0.179 │     0.3 │
│   NotEliminated │   62 │ 183 │  0.389 │   0.132 │
│           Total │  267 │ 203 │  0.432 │   0.568 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 20, 438 hulls

### Hull Counts

┌──────────────────────┬───────┐
│                Hulls │ Count │
├──────────────────────┼───────┤
│ Stock/Raines Frigate │   438 │
└──────────────────────┴───────┘


### Components

┌──────────────────────────┬────────────┬────────────┬──────────────────┐
│                    Names │    meanVal │ proportion │ scaledProportion │
├──────────────────────────┼────────────┼────────────┼──────────────────┤
│            PD-250mm Gun  │    1.65068 │  0.0734308 │          5.19146 │
│          WEAP-250mm Gun  │    549.338 │  0.0494788 │          3.49808 │
│              PD-&lt;line │ 0.00684932 │  0.0365854 │          2.58654 │
│     PD-Mk90 'Aurora' PDT │    0.23516 │  0.0253445 │          1.79182 │
│             EWAR-Jammers │   0.495434 │  0.0212225 │           1.5004 │
│ PD-Mk29 'Stonewall' PDT  │   0.303653 │  0.0149036 │          1.05367 │
│   PD-Mk95 'Sarissa' PDT  │   0.150685 │    0.01373 │         0.970691 │
│  PD-Mk20 'Defender' PDT  │   0.401826 │ 0.00895948 │         0.633423 │
│           DCTeamsCarried │    2.23288 │ 0.00803668 │         0.568182 │
│     MIS-Stock/SGM-1 Body │   0.936073 │  0.0074957 │         0.529936 │
│        OriginalPointCost │    432.288 │ 0.00733564 │          0.51862 │
│   MIS-Stock/SGM-H-2 Body │   0.552511 │ 0.00561954 │         0.397294 │
│     MIS-Stock/SGT-3 Body │   0.164384 │  0.0055423 │         0.391833 │
│        EWAR-Illuminators │  0.0205479 │ 0.00496141 │         0.350765 │
└──────────────────────────┴────────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬──────────────────────┐
│               variable │                value │
├────────────────────────┼──────────────────────┤
│                hullKey │ Stock/Raines Frigate │
│      OriginalPointCost │                  445 │
│        WEAP-250mm Gun  │                  533 │
│           EWAR-Jammers │                    1 │
│ PD-Mk25 'Rebound' PDT  │                    1 │
│          PD-250mm Gun  │                    2 │
│          RestoresTotal │                    3 │
│         DCTeamsCarried │                    5 │
└────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  69 │  167 │  0.158 │   0.381 │
│   NotEliminated │ 169 │   33 │  0.386 │   0.075 │
│           Total │ 238 │  200 │  0.543 │   0.457 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 21, 421 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │   421 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│               PD-250mm Gun  │  4.44893 │    0.19023 │           13.992 │
│             WEAP-250mm Gun  │  1182.32 │   0.102358 │          7.52877 │
│     PD-Mk20 'Defender' PDT  │  2.62708 │  0.0563022 │          4.14122 │
│      PD-Mk25 'Rebound' PDT  │ 0.866983 │  0.0513434 │          3.77648 │
│ DEC-Stock/EA99 Active Decoy │   1.2114 │  0.0363533 │          2.67391 │
│  DEC-Stock/EA12 Chaff Decoy │  6.66983 │  0.0303561 │           2.2328 │
│      MIS-Stock/SGM-H-3 Body │  1.66508 │  0.0276006 │          2.03012 │
│              DCTeamsCarried │   7.5677 │  0.0261809 │          1.92569 │
│               RestoresTotal │  3.92637 │  0.0230281 │          1.69379 │
│           OriginalPointCost │  1066.94 │  0.0174025 │          1.28002 │
│  DEC-Stock/EA20 Flare Decoy │  1.16865 │  0.0158556 │          1.16624 │
│                EWAR-Jammers │  0.28266 │  0.0116381 │         0.856025 │
│      MIS-Stock/SGM-H-2 Body │  1.13302 │  0.0110765 │         0.814717 │
│    PD-Mk29 'Stonewall' PDT  │ 0.118765 │ 0.00560287 │          0.41211 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────────────┐
│                variable │                        value │
├─────────────────────────┼──────────────────────────────┤
│                 hullKey │ Stock/Vauxhall Light Cruiser │
│       OriginalPointCost │                         1087 │
│         WEAP-250mm Gun  │                         1150 │
│  MIS-Stock/SGM-H-3 Body │                            6 │
│  PD-Mk25 'Rebound' PDT  │                            2 │
│ PD-Mk20 'Defender' PDT  │                            2 │
│           PD-250mm Gun  │                            5 │
│           RestoresTotal │                            4 │
│          DCTeamsCarried │                            7 │
└─────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  52 │  145 │  0.125 │   0.349 │
│   NotEliminated │ 156 │   62 │  0.376 │   0.149 │
│           Total │ 208 │  207 │  0.501 │   0.499 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 22, 401 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │   401 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬───────────┬────────────┬──────────────────┐
│                                 Names │   meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼───────────┼────────────┼──────────────────┤
│                  WEAP-450mm Casemate  │   950.309 │    0.33566 │          25.9203 │
│                           PD-&lt;line │ 0.0199501 │   0.097561 │          7.53385 │
│ MIS-Stock/Decoy Container (Line Ship) │   0.55611 │  0.0937763 │          7.24159 │
│                 PD-P20 'Bastion' PDT  │   2.73067 │  0.0927573 │           7.1629 │
│                   PD-P60 'Grazer' PDT │   1.15711 │  0.0778393 │           6.0109 │
│                  PD-P11 'Pavise' PDT  │   1.16459 │  0.0621093 │           4.7962 │
│   MIS-Stock/Decoy Container (Clipper) │  0.236908 │    0.04287 │          3.31051 │
│              MIS-Stock/Mine Container │  0.658354 │  0.0408037 │          3.15094 │
│                         RestoresTotal │   6.96509 │  0.0389095 │          3.00467 │
│                  MIS-Stock/SGM-2 Body │   15.5461 │  0.0371853 │          2.87152 │
│                        DCTeamsCarried │     6.399 │   0.021086 │           1.6283 │
│            DEC-Stock/EA20 Flare Decoy │    1.5212 │  0.0196584 │          1.51806 │
│                     OriginalPointCost │   1261.71 │  0.0196017 │          1.51368 │
│            DEC-Stock/EA12 Chaff Decoy │   4.39401 │  0.0190482 │          1.47094 │
│                            PD-Jammers │  0.042394 │  0.0182796 │          1.41158 │
└───────────────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────────┐
│              variable │             value │
├───────────────────────┼───────────────────┤
│               hullKey │ Stock/Bulk Hauler │
│     OriginalPointCost │              1199 │
│  WEAP-450mm Casemate  │               900 │
│       EWAR-Omnijammer │                 1 │
│ PD-P20 'Bastion' PDT  │                 5 │
│   PD-P60 'Grazer' PDT │                 1 │
│         RestoresTotal │                12 │
│        DCTeamsCarried │                 6 │
└───────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  129 │  55 │  0.139 │   0.325 │
│   NotEliminated │   67 │ 146 │  0.368 │   0.169 │
│           Total │  201 │ 196 │  0.494 │   0.506 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 23, 389 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │   389 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬───────────┬────────────┬──────────────────┐
│                                 Names │   meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼───────────┼────────────┼──────────────────┤
│                WEAP-TE45 Mass Driver  │   454.825 │   0.412803 │          32.8608 │
│                  PD-P11 'Pavise' PDT  │    1.2108 │  0.0626413 │          4.98651 │
│                 PD-P20 'Bastion' PDT  │   1.74293 │  0.0574333 │          4.57193 │
│              MIS-Stock/Mine Container │  0.843188 │  0.0506955 │          4.03557 │
│ MIS-Stock/Decoy Container (Line Ship) │  0.275064 │  0.0449958 │          3.58185 │
│                   PD-P60 'Grazer' PDT │  0.411311 │  0.0268411 │          2.13666 │
│   MIS-Stock/Decoy Container (Clipper) │  0.118252 │  0.0207581 │          1.65243 │
│                         RestoresTotal │   3.54756 │  0.0192249 │          1.53038 │
│                            PD-Jammers │ 0.0437018 │  0.0182796 │          1.45513 │
│                     OriginalPointCost │   1210.74 │  0.0182471 │          1.45254 │
│            DEC-Stock/EA20 Flare Decoy │   1.02314 │  0.0128263 │          1.02103 │
│            DEC-Stock/EA12 Chaff Decoy │   3.01285 │    0.01267 │          1.00858 │
│                        DCTeamsCarried │   3.84319 │  0.0122851 │         0.977946 │
│            MIS-Stock/Rocket Container │   0.18509 │  0.0101637 │         0.809076 │
└───────────────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬───────────────────┐
│               variable │             value │
├────────────────────────┼───────────────────┤
│                hullKey │ Stock/Bulk Hauler │
│      OriginalPointCost │              1208 │
│ WEAP-TE45 Mass Driver  │               425 │
│  PD-P20 'Bastion' PDT  │                 4 │
│   PD-P11 'Pavise' PDT  │                 2 │
│          RestoresTotal │                 8 │
│         DCTeamsCarried │                 2 │
└────────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  116 │  29 │  0.075 │   0.298 │
│   NotEliminated │   86 │ 158 │  0.406 │   0.221 │
│           Total │  187 │ 202 │  0.519 │   0.481 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 24, 363 hulls

### Hull Counts

┌─────────────────────────┬───────┐
│                   Hulls │ Count │
├─────────────────────────┼───────┤
│ Stock/Sprinter Corvette │   363 │
└─────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│             WEAP-120mm Gun  │   1166.56 │   0.105278 │          8.98081 │
│               PD-120mm Gun  │   1.73554 │  0.0970874 │          8.28212 │
│      PD-Mk25 'Rebound' PDT  │  0.490358 │  0.0250387 │          2.13594 │
│     PD-Mk20 'Defender' PDT  │  0.906336 │  0.0167481 │          1.42871 │
│                EWAR-Jammers │  0.258953 │ 0.00919315 │         0.784229 │
│  DEC-Stock/EA12 Chaff Decoy │   1.78237 │ 0.00699444 │         0.596666 │
│  DEC-Stock/EA20 Flare Decoy │  0.506887 │ 0.00592975 │         0.505842 │
│              DCTeamsCarried │     1.573 │ 0.00469217 │          0.40027 │
│           OriginalPointCost │   308.375 │ 0.00433687 │          0.36996 │
│               RestoresTotal │  0.625344 │ 0.00316235 │         0.269767 │
│ DEC-Stock/EA99 Active Decoy │  0.110193 │ 0.00285124 │         0.243227 │
│        MIS-Stock/SGT-3 Body │ 0.0826446 │ 0.00230929 │         0.196996 │
│           EWAR-Illuminators │ 0.0110193 │ 0.00220507 │         0.188105 │
│        MIS-Stock/SGM-1 Body │  0.275482 │ 0.00182822 │         0.155958 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────┬─────────────────────────┐
│          variable │                   value │
├───────────────────┼─────────────────────────┤
│           hullKey │ Stock/Sprinter Corvette │
│ OriginalPointCost │                     317 │
│   WEAP-120mm Gun  │                    1200 │
│      EWAR-Jammers │                       2 │
│     PD-120mm Gun  │                       2 │
│    DCTeamsCarried │                       1 │
└───────────────────┴─────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  87 │  147 │   0.24 │   0.405 │
│   NotEliminated │ 117 │   12 │  0.322 │   0.033 │
│           Total │ 204 │  159 │  0.562 │   0.438 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 25, 359 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Keystone Destroyer │   359 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│         WEAP-Mk550 Railgun  │  83.7855 │   0.172376 │          14.8685 │
│      WEAP-Mk600 Beam Cannon │ 0.520891 │   0.131413 │          11.3352 │
│               PD-250mm Gun  │  1.61003 │   0.058704 │          5.06359 │
│    PD-Mk29 'Stonewall' PDT  │  1.28969 │  0.0518826 │           4.4752 │
│             WEAP-250mm Gun  │  540.418 │   0.039896 │          3.44128 │
│     PD-Mk20 'Defender' PDT  │  1.40111 │  0.0256058 │          2.20866 │
│ DEC-Stock/EA99 Active Decoy │ 0.788301 │  0.0201725 │             1.74 │
│      PD-Mk95 'Sarissa' PDT  │ 0.203343 │  0.0151862 │           1.3099 │
│              DCTeamsCarried │  5.05292 │  0.0149065 │          1.28578 │
│  DEC-Stock/EA20 Flare Decoy │  1.21727 │  0.0140831 │          1.21476 │
│               RestoresTotal │  2.50696 │   0.012538 │          1.08148 │
│      PD-Mk25 'Rebound' PDT  │ 0.247911 │  0.0125193 │          1.07987 │
│           OriginalPointCost │  776.474 │  0.0107997 │         0.931543 │
│  DEC-Stock/EA12 Chaff Decoy │  2.65738 │  0.0103133 │         0.889586 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────────┐
│                 variable │                    value │
├──────────────────────────┼──────────────────────────┤
│                  hullKey │ Stock/Keystone Destroyer │
│        OriginalPointCost │                      759 │
│          WEAP-250mm Gun  │                      550 │
│   WEAP-Mk600 Beam Cannon │                        1 │
│             EWAR-Jammers │                        1 │
│  PD-Mk20 'Defender' PDT  │                        2 │
│ PD-Mk29 'Stonewall' PDT  │                        2 │
│            PD-250mm Gun  │                        1 │
│            RestoresTotal │                        1 │
│           DCTeamsCarried │                        2 │
└──────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  46 │  111 │  0.128 │   0.309 │
│   NotEliminated │ 151 │   51 │  0.421 │   0.142 │
│           Total │ 197 │  162 │  0.549 │   0.451 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 26, 319 hulls

### Hull Counts

┌──────────────────────┬───────┐
│                Hulls │ Count │
├──────────────────────┼───────┤
│ Stock/Raines Frigate │   319 │
└──────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│               PD-120mm Gun  │   1.4232 │  0.0699646 │          6.79161 │
│             WEAP-120mm Gun  │  541.809 │  0.0429695 │          4.17114 │
│           EWAR-Illuminators │ 0.141066 │  0.0248071 │          2.40807 │
│      MIS-Stock/SGM-H-2 Body │  2.90909 │  0.0215493 │          2.09184 │
│      PD-Mk95 'Sarissa' PDT  │ 0.269592 │  0.0178906 │          1.73668 │
│      MIS-Stock/SGM-H-3 Body │  0.84953 │  0.0106701 │          1.03577 │
│        MIS-Stock/SGM-2 Body │  4.80251 │ 0.00913825 │         0.887069 │
│                EWAR-Jammers │ 0.257053 │ 0.00801956 │         0.778476 │
│  DEC-Stock/EA20 Flare Decoy │ 0.601881 │ 0.00618756 │         0.600639 │
│ DEC-Stock/EA99 Active Decoy │ 0.250784 │ 0.00570247 │         0.553551 │
│           OriginalPointCost │  453.536 │ 0.00560523 │         0.544112 │
│              DCTeamsCarried │  2.09091 │ 0.00548105 │         0.532057 │
│     PD-Mk20 'Defender' PDT  │  0.31348 │ 0.00509061 │         0.494156 │
│      PD-Mk25 'Rebound' PDT  │ 0.109718 │ 0.00492334 │         0.477919 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬──────────────────────┐
│               variable │                value │
├────────────────────────┼──────────────────────┤
│                hullKey │ Stock/Raines Frigate │
│      OriginalPointCost │                  475 │
│        WEAP-120mm Gun  │                  550 │
│           EWAR-Jammers │                    2 │
│          PD-120mm Gun  │                    1 │
│ PD-Mk95 'Sarissa' PDT  │                    1 │
│          RestoresTotal │                    1 │
│         DCTeamsCarried │                    2 │
└────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  52 │  133 │  0.163 │   0.417 │
│   NotEliminated │ 107 │   27 │  0.335 │   0.085 │
│           Total │ 159 │  160 │  0.498 │   0.502 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 27, 278 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Feeder │   241 │
│     Stock/Tugboat │    29 │
│     Stock/Shuttle │     8 │
└───────────────────┴───────┘


### Components

┌──────────────────────────┬──────────┬────────────┬──────────────────┐
│                    Names │  meanVal │ proportion │ scaledProportion │
├──────────────────────────┼──────────┼────────────┼──────────────────┤
│        MIS-Stock/S3 Mine │  1.29137 │  0.0831596 │          9.26302 │
│            PD-100mm Gun  │ 0.543165 │  0.0349294 │          3.89074 │
│    MIS-Stock/S3 Net Mine │ 0.374101 │  0.0284075 │          3.16427 │
│          WEAP-100mm Gun  │  608.806 │  0.0241151 │          2.68614 │
│ MIS-Stock/S3 Sprint Mine │ 0.823741 │  0.0230382 │          2.56619 │
│   WEAP-TE45 Mass Driver  │  31.8345 │  0.0206487 │          2.30002 │
│     WEAP-450mm Casemate  │  76.4388 │  0.0187175 │          2.08492 │
│      PD-P60 'Grazer' PDT │ 0.399281 │   0.018621 │          2.07417 │
│       WEAP-400mm Plasma  │  40.4604 │  0.0174479 │          1.94349 │
│     MIS-Stock/SGM-1 Body │  3.30935 │  0.0168196 │          1.87351 │
│     MIS-Stock/SGT-3 Body │ 0.741007 │  0.0158571 │           1.7663 │
│     PD-P11 'Pavise' PDT  │ 0.359712 │  0.0132996 │          1.48143 │
│    PD-P20 'Bastion' PDT  │ 0.564748 │  0.0132994 │          1.48141 │
│     MIS-Stock/SGM-2 Body │  5.32014 │ 0.00882211 │         0.982681 │
│            RestoresTotal │  2.27698 │ 0.00881837 │         0.982265 │
└──────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────┬───────────────────┐
│             variable │             value │
├──────────────────────┼───────────────────┤
│              hullKey │ Stock/Bulk Feeder │
│    OriginalPointCost │               526 │
│      WEAP-100mm Gun  │               600 │
│ WEAP-450mm Casemate  │               125 │
│         EWAR-Jammers │                 1 │
│  PD-P60 'Grazer' PDT │                 1 │
│        RestoresTotal │                 2 │
│       DCTeamsCarried │                 4 │
└──────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │  124 │  49 │  0.176 │   0.446 │
│   NotEliminated │   13 │  92 │  0.331 │   0.047 │
│           Total │  141 │ 137 │  0.493 │   0.507 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 28, 270 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│       Stock/Ocello Cruiser │   185 │
│ Stock/Axford Heavy Cruiser │    85 │
└────────────────────────────┴───────┘


### Components

┌──────────────────────────┬──────────┬────────────┬──────────────────┐
│                    Names │  meanVal │ proportion │ scaledProportion │
├──────────────────────────┼──────────┼────────────┼──────────────────┤
│      WEAP-300mm Railgun  │  308.681 │   0.632779 │          72.5728 │
│   PD-Mk95 'Sarissa' PDT  │ 0.918519 │  0.0515914 │          5.91696 │
│     PD-Mk90 'Aurora' PDT │ 0.644444 │   0.042815 │           4.9104 │
│         WEAP-Beam Turret │ 0.107407 │  0.0393487 │          4.51286 │
│               PD-Jammers │ 0.111111 │  0.0322581 │          3.69964 │
│          EWAR-Omnijammer │ 0.144444 │  0.0310016 │          3.55554 │
│   PD-Mk25 'Rebound' PDT  │ 0.662963 │  0.0251794 │          2.88779 │
│ PD-Mk29 'Stonewall' PDT  │ 0.755556 │  0.0228597 │          2.62175 │
│       WEAP-400mm Plasma  │  49.6741 │  0.0208047 │          2.38606 │
│        OriginalPointCost │  1445.68 │  0.0151226 │           1.7344 │
│      PD-P60 'Grazer' PDT │ 0.318519 │  0.0144271 │          1.65463 │
│    PD-P20 'Bastion' PDT  │ 0.618519 │  0.0141465 │          1.62245 │
│  PD-Mk20 'Defender' PDT  │  1.01852 │  0.0139992 │          1.60555 │
│           DCTeamsCarried │  6.27407 │  0.0139204 │          1.59651 │
└──────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬──────────────────────┐
│               variable │                value │
├────────────────────────┼──────────────────────┤
│                hullKey │ Stock/Ocello Cruiser │
│      OriginalPointCost │                 1418 │
│    WEAP-300mm Railgun  │                  225 │
│ PD-Mk95 'Sarissa' PDT  │                    2 │
│    PD-P60 'Grazer' PDT │                    2 │
│          RestoresTotal │                    4 │
│         DCTeamsCarried │                    8 │
└────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   99 │  22 │  0.082 │   0.368 │
│   NotEliminated │   42 │ 106 │  0.394 │   0.156 │
│           Total │  128 │ 141 │  0.524 │   0.476 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 29, 269 hulls

### Hull Counts

┌─────────────────────────┬───────┐
│                   Hulls │ Count │
├─────────────────────────┼───────┤
│ Stock/Sprinter Corvette │   269 │
└─────────────────────────┴───────┘


### Components

┌─────────────────────────────┬────────────┬─────────────┬──────────────────┐
│                       Names │    meanVal │  proportion │ scaledProportion │
├─────────────────────────────┼────────────┼─────────────┼──────────────────┤
│      PD-Mk25 'Rebound' PDT  │   0.754647 │   0.0285554 │          3.28716 │
│               PD-250mm Gun  │    0.95539 │    0.026102 │          3.00473 │
│             WEAP-250mm Gun  │    435.658 │   0.0240992 │          2.77419 │
│        MIS-Stock/SGM-1 Body │    3.73978 │   0.0183919 │          2.11719 │
│     PD-Mk20 'Defender' PDT  │    1.04833 │   0.0143555 │          1.65254 │
│ DEC-Stock/EA99 Active Decoy │   0.598513 │   0.0114762 │          1.32109 │
│                EWAR-Jammers │   0.427509 │   0.0112469 │          1.29469 │
│  DEC-Stock/EA12 Chaff Decoy │    2.33829 │  0.00679985 │         0.782767 │
│  DEC-Stock/EA20 Flare Decoy │   0.416357 │  0.00360941 │         0.415498 │
│           OriginalPointCost │    317.357 │  0.00330744 │         0.380736 │
│              DCTeamsCarried │    1.38662 │  0.00306512 │         0.352841 │
│               RestoresTotal │   0.453532 │  0.00169959 │         0.195649 │
│    PD-Mk29 'Stonewall' PDT  │  0.0557621 │  0.00168086 │         0.193493 │
│           EWAR-Illuminators │ 0.00371747 │ 0.000551268 │        0.0634593 │
└─────────────────────────────┴────────────┴─────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬─────────────────────────┐
│                 variable │                   value │
├──────────────────────────┼─────────────────────────┤
│                  hullKey │ Stock/Sprinter Corvette │
│        OriginalPointCost │                     308 │
│          WEAP-250mm Gun  │                     446 │
│  PD-Mk20 'Defender' PDT  │                       2 │
│ PD-Mk29 'Stonewall' PDT  │                       1 │
│            PD-250mm Gun  │                       1 │
│            RestoresTotal │                       1 │
│           DCTeamsCarried │                       2 │
└──────────────────────────┴─────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   87 │  43 │   0.16 │   0.323 │
│   NotEliminated │   38 │ 101 │  0.375 │   0.141 │
│           Total │  144 │ 125 │  0.465 │   0.535 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 30, 246 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Feeder │   200 │
│     Stock/Tugboat │    29 │
│     Stock/Shuttle │    17 │
└───────────────────┴───────┘


### Components

┌────────────────────────┬───────────┬────────────┬──────────────────┐
│                  Names │   meanVal │ proportion │ scaledProportion │
├────────────────────────┼───────────┼────────────┼──────────────────┤
│        WEAP-100mm Gun  │   2510.81 │  0.0880065 │          11.0781 │
│     WEAP-400mm Plasma  │   140.154 │  0.0534822 │          6.73224 │
│          PD-100mm Gun  │  0.837398 │  0.0476521 │          5.99835 │
│    PD-P60 'Grazer' PDT │  0.666667 │  0.0275122 │          3.46318 │
│  MIS-Stock/S3 Net Mine │  0.325203 │   0.021852 │          2.75068 │
│   WEAP-250mm Casemate  │   142.646 │  0.0175981 │          2.21521 │
│  PD-P20 'Bastion' PDT  │  0.768293 │  0.0160102 │          2.01533 │
│          RestoresTotal │   3.57724 │  0.0122593 │          1.54318 │
│      MIS-Stock/S3 Mine │  0.146341 │ 0.00833912 │          1.04971 │
│             PD-Jammers │ 0.0284553 │ 0.00752688 │         0.947469 │
│ WEAP-TE45 Mass Driver  │   13.0081 │ 0.00746619 │         0.939829 │
│   PD-P11 'Pavise' PDT  │  0.227642 │  0.0074478 │         0.937514 │
│         DCTeamsCarried │   3.55691 │ 0.00719028 │         0.905099 │
│      OriginalPointCost │   523.943 │ 0.00499356 │          0.62858 │
│        EWAR-Omnijammer │ 0.0203252 │ 0.00397456 │          0.50031 │
└────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────────┐
│              variable │             value │
├───────────────────────┼───────────────────┤
│               hullKey │ Stock/Bulk Feeder │
│     OriginalPointCost │               494 │
│       WEAP-100mm Gun  │              2600 │
│    WEAP-400mm Plasma  │               100 │
│ PD-P20 'Bastion' PDT  │                 2 │
│         PD-100mm Gun  │                 2 │
│         RestoresTotal │                 5 │
│        DCTeamsCarried │                 3 │
└───────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  28 │   95 │  0.114 │   0.386 │
│   NotEliminated │ 110 │   13 │  0.447 │   0.053 │
│           Total │ 138 │  108 │  0.561 │   0.439 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 31, 235 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │   235 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│               PD-250mm Gun  │  4.57021 │    0.10908 │          14.3735 │
│             WEAP-250mm Gun  │  2119.85 │   0.102442 │          13.4988 │
│      PD-Mk25 'Rebound' PDT  │  1.11489 │  0.0368547 │          4.85635 │
│ DEC-Stock/EA99 Active Decoy │  1.91915 │  0.0321477 │          4.23611 │
│     PD-Mk20 'Defender' PDT  │  2.33191 │  0.0278966 │          3.67594 │
│              DCTeamsCarried │   7.5617 │  0.0146024 │          1.92417 │
│  DEC-Stock/EA20 Flare Decoy │  1.88511 │  0.0142765 │          1.88122 │
│               RestoresTotal │  4.15319 │  0.0135967 │          1.79164 │
│      MIS-Stock/SGM-H-3 Body │  1.36596 │  0.0126388 │          1.66542 │
│           OriginalPointCost │  1194.81 │  0.0108782 │          1.43343 │
│  DEC-Stock/EA12 Chaff Decoy │  3.77447 │ 0.00958898 │          1.26354 │
│        PD-Mk90 'Aurora' PDT │ 0.123404 │ 0.00713583 │         0.940289 │
│      MIS-Stock/SGM-H-2 Body │  1.03404 │ 0.00564276 │         0.743548 │
│        MIS-Stock/SGM-2 Body │  3.82979 │ 0.00536842 │         0.707398 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬──────────────────────────────┐
│                    variable │                        value │
├─────────────────────────────┼──────────────────────────────┤
│                     hullKey │ Stock/Vauxhall Light Cruiser │
│           OriginalPointCost │                         1171 │
│             WEAP-250mm Gun  │                         2200 │
│                EWAR-Jammers │                            2 │
│    PD-Mk29 'Stonewall' PDT  │                            2 │
│               PD-250mm Gun  │                            3 │
│  DEC-Stock/EA12 Chaff Decoy │                           12 │
│ DEC-Stock/EA99 Active Decoy │                            2 │
│               RestoresTotal │                            2 │
│              DCTeamsCarried │                            4 │
└─────────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  26 │  100 │  0.111 │   0.426 │
│   NotEliminated │  83 │   26 │  0.353 │   0.111 │
│           Total │ 109 │  126 │  0.464 │   0.536 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 32, 231 hulls

### Hull Counts

┌──────────────────────┬───────┐
│                Hulls │ Count │
├──────────────────────┼───────┤
│ Stock/Raines Frigate │   231 │
└──────────────────────┴───────┘


### Components

┌──────────────────────────┬───────────┬────────────┬──────────────────┐
│                    Names │   meanVal │ proportion │ scaledProportion │
├──────────────────────────┼───────────┼────────────┼──────────────────┤
│            PD-120mm Gun  │   2.37229 │  0.0844506 │          11.3208 │
│          WEAP-120mm Gun  │   1117.52 │  0.0641789 │          8.60331 │
│            PD-250mm Gun  │  0.251082 │ 0.00589072 │         0.789662 │
│   PD-Mk95 'Sarissa' PDT  │  0.108225 │ 0.00520075 │         0.697171 │
│             EWAR-Jammers │  0.212121 │ 0.00479218 │         0.642401 │
│          WEAP-250mm Gun  │   99.9264 │ 0.00474676 │         0.636313 │
│     MIS-Stock/SGM-1 Body │   1.06926 │  0.0045157 │         0.605339 │
│           DCTeamsCarried │   2.25974 │ 0.00428952 │         0.575018 │
│        EWAR-Illuminators │  0.030303 │ 0.00385888 │          0.51729 │
│  PD-Mk20 'Defender' PDT  │  0.320346 │ 0.00376705 │         0.504981 │
│ PD-Mk29 'Stonewall' PDT  │  0.134199 │ 0.00347378 │         0.465667 │
│        OriginalPointCost │   383.368 │ 0.00343099 │          0.45993 │
│   PD-Mk25 'Rebound' PDT  │ 0.0779221 │   0.002532 │          0.33942 │
│            RestoresTotal │  0.774892 │ 0.00249366 │          0.33428 │
└──────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────┐
│                variable │                value │
├─────────────────────────┼──────────────────────┤
│                 hullKey │ Stock/Raines Frigate │
│       OriginalPointCost │                  403 │
│         WEAP-120mm Gun  │                 1200 │
│           PD-120mm Gun  │                    2 │
│ PD-Mk20 'Defender' PDT  │                    2 │
│           RestoresTotal │                    3 │
│          DCTeamsCarried │                    5 │
└─────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  92 │   15 │  0.398 │   0.065 │
│ Destroyed/Other │  36 │   88 │  0.156 │   0.381 │
│           Total │ 128 │  103 │  0.554 │   0.446 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 33, 224 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│     Stock/Tugboat │   207 │
│ Stock/Bulk Feeder │    17 │
└───────────────────┴───────┘


### Components

┌────────────────────────────┬───────────┬────────────┬──────────────────┐
│                      Names │   meanVal │ proportion │ scaledProportion │
├────────────────────────────┼───────────┼────────────┼──────────────────┤
│       WEAP-250mm Casemate  │   379.683 │  0.0426519 │          5.89624 │
│        PD-P60 'Grazer' PDT │  0.709821 │  0.0266734 │          3.68736 │
│              PD-100mm Gun  │       0.5 │  0.0259079 │          3.58154 │
│            WEAP-100mm Gun  │   615.746 │  0.0196524 │          2.71676 │
│      PD-P20 'Bastion' PDT  │  0.794643 │  0.0150784 │          2.08445 │
│                 PD-Jammers │ 0.0446429 │  0.0107527 │          1.48646 │
│       PD-P11 'Pavise' PDT  │  0.200893 │ 0.00598484 │          0.82735 │
│             DCTeamsCarried │   2.57589 │ 0.00474148 │         0.655467 │
│               EWAR-Jammers │  0.160714 │ 0.00352078 │         0.486717 │
│              RestoresTotal │   1.08929 │ 0.00339918 │         0.469906 │
│          OriginalPointCost │   322.031 │ 0.00279471 │         0.386344 │
│       MIS-Stock/SGT-3 Body │  0.160714 │ 0.00277115 │         0.383087 │
│ DEC-Stock/EA20 Flare Decoy │   0.34375 │ 0.00248147 │         0.343041 │
│            EWAR-Omnijammer │ 0.0133929 │ 0.00238474 │         0.329669 │
└────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────┬───────────────┐
│             variable │         value │
├──────────────────────┼───────────────┤
│              hullKey │ Stock/Tugboat │
│    OriginalPointCost │           329 │
│      WEAP-100mm Gun  │           600 │
│ WEAP-250mm Casemate  │           399 │
│  PD-P60 'Grazer' PDT │             2 │
│       DCTeamsCarried │             2 │
└──────────────────────┴───────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  96 │   22 │  0.429 │   0.098 │
│ Destroyed/Other │  38 │   68 │   0.17 │   0.304 │
│           Total │ 134 │   90 │  0.598 │   0.402 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 34, 216 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│ Stock/Axford Heavy Cruiser │   197 │
│       Stock/Ocello Cruiser │    19 │
└────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│      MIS-Stock/SGM-H-3 Body │  8.17593 │   0.069533 │          9.96833 │
│      MIS-Stock/SGM-H-2 Body │  12.6528 │  0.0634637 │          9.09822 │
│             WEAP-450mm Gun  │  587.046 │  0.0545783 │          7.82441 │
│    PD-Mk29 'Stonewall' PDT  │  2.01389 │   0.048745 │          6.98813 │
│ DEC-Stock/EA99 Active Decoy │  1.92593 │  0.0296529 │          4.25107 │
│           EWAR-Illuminators │ 0.222222 │  0.0264609 │          3.79346 │
│     PD-Mk20 'Defender' PDT  │  2.31944 │   0.025504 │          3.65628 │
│        PD-Mk90 'Aurora' PDT │ 0.458333 │  0.0243602 │          3.49231 │
│      PD-Mk95 'Sarissa' PDT  │ 0.425926 │  0.0191388 │          2.74375 │
│        MIS-Stock/SGM-1 Body │  4.81019 │  0.0189952 │          2.72317 │
│        MIS-Stock/SGT-3 Body │  1.13889 │  0.0189362 │          2.71471 │
│           OriginalPointCost │  2249.36 │  0.0188236 │          2.69858 │
│               RestoresTotal │  5.78241 │  0.0173999 │          2.49447 │
│              DCTeamsCarried │  9.78241 │  0.0173635 │          2.48925 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬────────────────────────────┐
│                variable │                      value │
├─────────────────────────┼────────────────────────────┤
│                 hullKey │ Stock/Axford Heavy Cruiser │
│       OriginalPointCost │                       2301 │
│         WEAP-450mm Gun  │                        560 │
│  MIS-Stock/SGM-H-3 Body │                         16 │
│  PD-Mk95 'Sarissa' PDT  │                          2 │
│ PD-Mk20 'Defender' PDT  │                          3 │
│    PD-Mk90 'Aurora' PDT │                          2 │
│           RestoresTotal │                          6 │
│          DCTeamsCarried │                          9 │
└─────────────────────────┴────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  92 │   37 │  0.426 │   0.171 │
│ Destroyed/Other │  12 │   75 │  0.056 │   0.347 │
│           Total │ 104 │  112 │  0.481 │   0.519 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 35, 204 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│     Stock/Tugboat │   127 │
│ Stock/Bulk Feeder │    77 │
└───────────────────┴───────┘


### Components

┌───────────────────────┬───────────┬────────────┬──────────────────┐
│                 Names │   meanVal │ proportion │ scaledProportion │
├───────────────────────┼───────────┼────────────┼──────────────────┤
│  WEAP-250mm Casemate  │   664.431 │   0.067975 │          10.3182 │
│ MIS-Stock/S3 Net Mine │  0.779412 │  0.0434308 │          6.59253 │
│   PD-P60 'Grazer' PDT │   0.52451 │    0.01795 │          2.72471 │
│  MIS-Stock/SGM-2 Body │   13.0588 │  0.0158905 │          2.41209 │
│   MIS-Stock/S1 Rocket │   6.16176 │  0.0140203 │          2.12819 │
│    WEAP-400mm Plasma  │   39.5147 │  0.0125042 │          1.89807 │
│ PD-P20 'Bastion' PDT  │  0.686275 │  0.0118594 │          1.80018 │
│            PD-Jammers │ 0.0539216 │   0.011828 │          1.79541 │
│  PD-P11 'Pavise' PDT  │  0.392157 │  0.0106397 │          1.61505 │
│          EWAR-Jammers │  0.348039 │ 0.00694377 │          1.05402 │
│       EWAR-Omnijammer │ 0.0343137 │ 0.00556439 │         0.844641 │
│     EWAR-Illuminators │ 0.0441176 │ 0.00496141 │         0.753113 │
│         RestoresTotal │   1.71569 │ 0.00487587 │         0.740129 │
│        DCTeamsCarried │      2.75 │    0.00461 │         0.699771 │
│  MIS-Stock/SGT-3 Body │  0.259804 │ 0.00407975 │         0.619282 │
└───────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────────┐
│              variable │             value │
├───────────────────────┼───────────────────┤
│               hullKey │ Stock/Bulk Feeder │
│     OriginalPointCost │               601 │
│  WEAP-250mm Casemate  │               700 │
│  MIS-Stock/SGM-2 Body │                40 │
│ PD-P20 'Bastion' PDT  │                 1 │
│         RestoresTotal │                 6 │
│        DCTeamsCarried │                 4 │
└───────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  33 │   71 │  0.162 │   0.348 │
│   NotEliminated │  83 │   17 │  0.407 │   0.083 │
│           Total │ 116 │   88 │  0.569 │   0.431 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 36, 200 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Keystone Destroyer │   200 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬─────────┬────────────┬──────────────────┐
│                       Names │ meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼─────────┼────────────┼──────────────────┤
│      WEAP-Mk600 Beam Cannon │   0.655 │   0.092059 │          14.2535 │
│               PD-120mm Gun  │    2.07 │  0.0638003 │           9.8782 │
│         WEAP-Mk550 Railgun  │   47.22 │  0.0541216 │          8.37964 │
│             WEAP-120mm Gun  │  590.25 │  0.0293488 │          4.54407 │
│        MIS-Stock/SGT-3 Body │   0.775 │  0.0119313 │          1.84733 │
│     PD-Mk20 'Defender' PDT  │    1.16 │  0.0118102 │          1.82858 │
│    PD-Mk29 'Stonewall' PDT  │   0.425 │ 0.00952488 │          1.47474 │
│      PD-Mk25 'Rebound' PDT  │   0.305 │ 0.00858067 │          1.32855 │
│      PD-Mk95 'Sarissa' PDT  │   0.175 │ 0.00728105 │          1.12732 │
│              DCTeamsCarried │   4.415 │ 0.00725602 │          1.12345 │
│                EWAR-Jammers │   0.335 │ 0.00655257 │          1.01453 │
│ DEC-Stock/EA99 Active Decoy │    0.45 │ 0.00641528 │         0.993278 │
│               RestoresTotal │    2.09 │ 0.00582319 │         0.901604 │
│  DEC-Stock/EA12 Chaff Decoy │    2.64 │ 0.00570798 │         0.883767 │
└─────────────────────────────┴─────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬──────────────────────────┐
│                    variable │                    value │
├─────────────────────────────┼──────────────────────────┤
│                     hullKey │ Stock/Keystone Destroyer │
│           OriginalPointCost │                      716 │
│             WEAP-120mm Gun  │                      600 │
│      WEAP-Mk600 Beam Cannon │                        1 │
│               PD-120mm Gun  │                        4 │
│  DEC-Stock/EA12 Chaff Decoy │                        5 │
│  DEC-Stock/EA20 Flare Decoy │                        5 │
│ DEC-Stock/EA99 Active Decoy │                        5 │
│               RestoresTotal │                        2 │
│              DCTeamsCarried │                        4 │
└─────────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  41 │   91 │  0.205 │   0.455 │
│   NotEliminated │  51 │   17 │  0.255 │   0.085 │
│           Total │  92 │  108 │   0.46 │    0.54 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 37, 197 hulls

### Hull Counts

┌─────────────────────────┬───────┐
│                   Hulls │ Count │
├─────────────────────────┼───────┤
│ Stock/Sprinter Corvette │   197 │
└─────────────────────────┴───────┘


### Components

┌─────────────────────────────┬────────────┬─────────────┬──────────────────┐
│                       Names │    meanVal │  proportion │ scaledProportion │
├─────────────────────────────┼────────────┼─────────────┼──────────────────┤
│             WEAP-120mm Gun  │    549.675 │   0.0269213 │           4.2317 │
│               PD-120mm Gun  │   0.883249 │   0.0268146 │          4.21493 │
│               PD-250mm Gun  │   0.888325 │   0.0177737 │          2.79381 │
│      PD-Mk25 'Rebound' PDT  │   0.634518 │   0.0175833 │          2.76389 │
│             WEAP-250mm Gun  │    380.391 │     0.01541 │          2.42226 │
│     PD-Mk20 'Defender' PDT  │    1.05584 │   0.0105885 │          1.66438 │
│  DEC-Stock/EA20 Flare Decoy │    0.80203 │  0.00509185 │         0.800376 │
│ DEC-Stock/EA99 Active Decoy │   0.279188 │  0.00392045 │         0.616247 │
│              DCTeamsCarried │    1.54822 │  0.00250633 │         0.393964 │
│           OriginalPointCost │    301.102 │  0.00229811 │         0.361235 │
│  DEC-Stock/EA12 Chaff Decoy │    1.07614 │  0.00229184 │          0.36025 │
│               RestoresTotal │   0.675127 │  0.00185283 │         0.291243 │
│           EWAR-Illuminators │ 0.00507614 │ 0.000551268 │        0.0866526 │
│        MIS-Stock/SGM-1 Body │   0.142132 │ 0.000511902 │        0.0804647 │
└─────────────────────────────┴────────────┴─────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬─────────────────────────┐
│               variable │                   value │
├────────────────────────┼─────────────────────────┤
│                hullKey │ Stock/Sprinter Corvette │
│      OriginalPointCost │                     295 │
│        WEAP-120mm Gun  │                     500 │
│        WEAP-250mm Gun  │                     398 │
│          PD-120mm Gun  │                       1 │
│ PD-Mk25 'Rebound' PDT  │                       2 │
│          PD-250mm Gun  │                       1 │
│          RestoresTotal │                       1 │
│         DCTeamsCarried │                       2 │
└────────────────────────┴─────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  45 │   63 │  0.228 │    0.32 │
│   NotEliminated │  72 │   17 │  0.365 │   0.086 │
│           Total │ 117 │   80 │  0.594 │   0.406 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 38, 193 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Solomon Battleship │   193 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│            WEAP-Beam Turret │  0.953368 │   0.249661 │           40.057 │
│                 PD-&lt;line │ 0.0414508 │   0.097561 │          15.6532 │
│    PD-Mk29 'Stonewall' PDT  │   2.79275 │  0.0603989 │          9.69074 │
│         WEAP-300mm Railgun  │   27.6528 │  0.0405205 │          6.50134 │
│             EWAR-Omnijammer │  0.248705 │  0.0381558 │          6.12193 │
│     PD-Mk20 'Defender' PDT  │    3.7513 │   0.036856 │          5.91339 │
│ DEC-Stock/EA99 Active Decoy │   2.58549 │  0.0355692 │          5.70692 │
│        PD-Mk90 'Aurora' PDT │  0.569948 │  0.0270669 │          4.34277 │
│      MIS-Stock/SGM-H-3 Body │   3.41451 │  0.0259469 │          4.16307 │
│              DCTeamsCarried │   14.5078 │  0.0230089 │          3.69168 │
│               RestoresTotal │   8.04145 │   0.021621 │            3.469 │
│        MIS-Stock/SGT-3 Body │   1.40415 │  0.0208606 │          3.34699 │
│           OriginalPointCost │   2621.36 │  0.0196009 │          3.14488 │
│      PD-Mk95 'Sarissa' PDT  │  0.336788 │  0.0135219 │          2.16954 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────────┐
│                 variable │                    value │
├──────────────────────────┼──────────────────────────┤
│                  hullKey │ Stock/Solomon Battleship │
│        OriginalPointCost │                     2660 │
│          WEAP-450mm Gun  │                       50 │
│         WEAP-Beam Turret │                        1 │
│   PD-Mk95 'Sarissa' PDT  │                        2 │
│   PD-Mk25 'Rebound' PDT  │                        2 │
│  PD-Mk20 'Defender' PDT  │                        2 │
│ PD-Mk29 'Stonewall' PDT  │                        4 │
│            RestoresTotal │                        8 │
│           DCTeamsCarried │                       13 │
└──────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  79 │   36 │  0.409 │   0.187 │
│ Destroyed/Other │  14 │   64 │  0.073 │   0.332 │
│           Total │  93 │  100 │  0.482 │   0.518 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 39, 188 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Solomon Battleship │   188 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│            WEAP-Beam Turret │ 0.388298 │  0.0990502 │          16.3148 │
│             WEAP-450mm Gun  │  926.266 │  0.0749527 │          12.3457 │
│    PD-Mk29 'Stonewall' PDT  │  2.77128 │  0.0583819 │          9.61624 │
│      PD-Mk25 'Rebound' PDT  │  1.63298 │  0.0431847 │          7.11307 │
│     PD-Mk20 'Defender' PDT  │  3.49468 │  0.0334453 │          5.50887 │
│ DEC-Stock/EA99 Active Decoy │  2.24468 │  0.0300805 │          4.95465 │
│              DCTeamsCarried │  13.6117 │  0.0210285 │          3.46366 │
│               RestoresTotal │  7.53723 │  0.0197403 │          3.25148 │
│           OriginalPointCost │  2442.06 │  0.0177871 │          2.92976 │
│  DEC-Stock/EA20 Flare Decoy │  1.64362 │ 0.00995811 │          1.64023 │
│        PD-Mk90 'Aurora' PDT │ 0.202128 │ 0.00935039 │          1.54013 │
│  DEC-Stock/EA12 Chaff Decoy │  4.48404 │ 0.00911332 │          1.50108 │
│      PD-Mk95 'Sarissa' PDT  │ 0.228723 │ 0.00894529 │           1.4734 │
│         WEAP-300mm Railgun  │  5.69149 │ 0.00812385 │           1.3381 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────────┐
│                 variable │                    value │
├──────────────────────────┼──────────────────────────┤
│                  hullKey │ Stock/Solomon Battleship │
│        OriginalPointCost │                     2494 │
│          WEAP-450mm Gun  │                      980 │
│  PD-Mk20 'Defender' PDT  │                        5 │
│ PD-Mk29 'Stonewall' PDT  │                        4 │
│            RestoresTotal │                        6 │
│           DCTeamsCarried │                       12 │
└──────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   40 │  77 │   0.41 │   0.213 │
│ Destroyed/Other │   61 │  10 │  0.053 │   0.324 │
│           Total │   87 │ 101 │  0.537 │   0.463 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 40, 185 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│ Stock/Axford Heavy Cruiser │    99 │
│       Stock/Ocello Cruiser │    86 │
└────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│                 PD-&lt;line │ 0.0216216 │  0.0487805 │          8.16506 │
│             WEAP-450mm Gun  │   498.438 │  0.0396896 │          6.64339 │
│        PD-Mk90 'Aurora' PDT │  0.724324 │  0.0329724 │          5.51905 │
│      PD-Mk95 'Sarissa' PDT  │  0.837838 │  0.0322446 │          5.39723 │
│    PD-Mk29 'Stonewall' PDT  │   1.05946 │  0.0219632 │          3.67629 │
│      PD-Mk25 'Rebound' PDT  │  0.827027 │   0.021522 │          3.60244 │
│             WEAP-250mm Gun  │   562.897 │  0.0214144 │          3.58443 │
│             EWAR-Omnijammer │  0.135135 │  0.0198728 │          3.32639 │
│ DEC-Stock/EA99 Active Decoy │   1.33514 │  0.0176064 │          2.94702 │
│     PD-Mk20 'Defender' PDT  │   1.58378 │  0.0149155 │          2.49661 │
│           EWAR-Illuminators │   0.12973 │  0.0132304 │          2.21456 │
│  DEC-Stock/EA20 Flare Decoy │   2.21081 │  0.0131808 │          2.20625 │
│              DCTeamsCarried │   8.23784 │  0.0125234 │          2.09622 │
│               RestoresTotal │   4.38919 │   0.011312 │          1.89345 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬──────────────────────┐
│               variable │                value │
├────────────────────────┼──────────────────────┤
│                hullKey │ Stock/Ocello Cruiser │
│      OriginalPointCost │                 1528 │
│        WEAP-450mm Gun  │                  475 │
│        WEAP-250mm Gun  │                  550 │
│           EWAR-Jammers │                    1 │
│      EWAR-Illuminators │                    1 │
│        EWAR-Omnijammer │                    2 │
│ PD-Mk95 'Sarissa' PDT  │                    2 │
│   PD-Mk90 'Aurora' PDT │                    2 │
│             PD-Jammers │                    1 │
│          RestoresTotal │                    1 │
│         DCTeamsCarried │                    6 │
└────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  75 │   23 │  0.405 │   0.124 │
│ Destroyed/Other │  18 │   69 │  0.097 │   0.373 │
│           Total │  93 │   92 │  0.503 │   0.497 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 41, 178 hulls

### Hull Counts

┌──────────────────────┬───────┐
│                Hulls │ Count │
├──────────────────────┼───────┤
│ Stock/Raines Frigate │   178 │
└──────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬─────────────┬──────────────────┐
│                       Names │   meanVal │  proportion │ scaledProportion │
├─────────────────────────────┼───────────┼─────────────┼──────────────────┤
│               PD-120mm Gun  │   3.03933 │   0.0833719 │          14.5039 │
│             WEAP-120mm Gun  │   1763.64 │   0.0780466 │          13.5775 │
│           EWAR-Illuminators │ 0.0505618 │  0.00496141 │         0.863118 │
│              DCTeamsCarried │   2.41011 │  0.00352529 │         0.613282 │
│                EWAR-Jammers │  0.196629 │  0.00342298 │         0.595484 │
│    PD-Mk29 'Stonewall' PDT  │  0.140449 │  0.00280143 │         0.487355 │
│           OriginalPointCost │   382.685 │  0.00263908 │         0.459112 │
│               RestoresTotal │  0.921348 │   0.0022847 │          0.39746 │
│      MIS-Stock/SGM-H-2 Body │  0.516854 │  0.00213636 │         0.371654 │
│     PD-Mk20 'Defender' PDT  │  0.202247 │  0.00183262 │         0.318814 │
│ DEC-Stock/EA99 Active Decoy │ 0.0898876 │  0.00114049 │         0.198408 │
│             WEAP-250mm Gun  │    27.809 │  0.00101791 │         0.177083 │
│               PD-250mm Gun  │ 0.0449438 │ 0.000812513 │          0.14135 │
│        MIS-Stock/SGM-2 Body │  0.764045 │ 0.000811228 │         0.141126 │
└─────────────────────────────┴───────────┴─────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────┐
│                variable │                value │
├─────────────────────────┼──────────────────────┤
│                 hullKey │ Stock/Raines Frigate │
│       OriginalPointCost │                  388 │
│         WEAP-120mm Gun  │                 1700 │
│            EWAR-Jammers │                    1 │
│           PD-120mm Gun  │                    2 │
│ PD-Mk20 'Defender' PDT  │                    1 │
│           RestoresTotal │                    1 │
│          DCTeamsCarried │                    2 │
└─────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  32 │   54 │   0.18 │   0.303 │
│   NotEliminated │  86 │    6 │  0.483 │   0.034 │
│           Total │ 118 │   60 │  0.663 │   0.337 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 42, 166 hulls

### Hull Counts

┌────────────────────────┬───────┐
│                  Hulls │ Count │
├────────────────────────┼───────┤
│      Stock/Bulk Hauler │   165 │
│ Stock/Container Hauler │     1 │
└────────────────────────┴───────┘


### Components

┌───────────────────────────────────────┬──────────┬────────────┬──────────────────┐
│                                 Names │  meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼──────────┼────────────┼──────────────────┤
│                  WEAP-250mm Casemate  │  994.572 │  0.0827968 │          15.4451 │
│                 PD-P20 'Bastion' PDT  │  1.93373 │  0.0271919 │          5.07243 │
│ MIS-Stock/Decoy Container (Line Ship) │ 0.271084 │  0.0189235 │          3.53002 │
│                WEAP-TE45 Mass Driver  │  46.6867 │  0.0180822 │          3.37309 │
│            MIS-Stock/Rocket Container │  0.60241 │  0.0141163 │          2.63329 │
│                   PD-P60 'Grazer' PDT │ 0.506024 │  0.0140916 │          2.62868 │
│   MIS-Stock/Decoy Container (Clipper) │ 0.174699 │  0.0130866 │          2.44121 │
│                  PD-P11 'Pavise' PDT  │  0.53012 │  0.0117037 │          2.18323 │
│                  MIS-Stock/SGM-2 Body │  10.6265 │  0.0105221 │          1.96282 │
│                         RestoresTotal │  4.45783 │   0.010309 │          1.92306 │
│                    WEAP-400mm Plasma  │  33.7952 │ 0.00870222 │          1.62333 │
│            DEC-Stock/EA20 Flare Decoy │  1.60241 │ 0.00857235 │           1.5991 │
│                        DCTeamsCarried │  6.05422 │ 0.00825855 │          1.54057 │
│            DEC-Stock/EA12 Chaff Decoy │  3.91566 │ 0.00702688 │          1.31081 │
│                     OriginalPointCost │  994.349 │ 0.00639497 │          1.19293 │
└───────────────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬───────────────────┐
│                   variable │             value │
├────────────────────────────┼───────────────────┤
│                    hullKey │ Stock/Bulk Hauler │
│          OriginalPointCost │              1063 │
│       WEAP-250mm Casemate  │              1000 │
│      PD-P20 'Bastion' PDT  │                 3 │
│ DEC-Stock/EA12 Chaff Decoy │                 5 │
│ DEC-Stock/EA20 Flare Decoy │                 5 │
│              RestoresTotal │                 6 │
│             DCTeamsCarried │                10 │
└────────────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  81 │   18 │  0.488 │   0.108 │
│ Destroyed/Other │  26 │   41 │  0.157 │   0.247 │
│           Total │ 107 │   59 │  0.645 │   0.355 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 43, 165 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │   165 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬───────────┬────────────┬──────────────────┐
│                                 Names │   meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼───────────┼────────────┼──────────────────┤
│                  WEAP-250mm Casemate  │   1793.61 │   0.148416 │          27.8536 │
│ MIS-Stock/Decoy Container (Line Ship) │  0.563636 │  0.0391085 │           7.3396 │
│                 PD-P20 'Bastion' PDT  │   1.79394 │  0.0250741 │          4.70573 │
│                   PD-P60 'Grazer' PDT │  0.684848 │  0.0189566 │          3.55763 │
│                  PD-P11 'Pavise' PDT  │  0.642424 │  0.0140976 │          2.64574 │
│   MIS-Stock/Decoy Container (Clipper) │  0.181818 │  0.0135379 │           2.5407 │
│                         RestoresTotal │   5.38182 │  0.0123708 │          2.32166 │
│            DEC-Stock/EA20 Flare Decoy │   1.87879 │ 0.00999033 │          1.87491 │
│                  MIS-Stock/SGM-2 Body │   9.33333 │ 0.00918597 │          1.72396 │
│                        DCTeamsCarried │   6.20606 │ 0.00841469 │          1.57921 │
│            DEC-Stock/EA12 Chaff Decoy │   4.69697 │  0.0083782 │          1.57236 │
│                     EWAR-Illuminators │ 0.0727273 │ 0.00661521 │           1.2415 │
│                     OriginalPointCost │   1022.27 │ 0.00653494 │          1.22643 │
│              MIS-Stock/Mine Container │  0.254545 │  0.0064915 │          1.21828 │
│                            PD-Jammers │ 0.0363636 │ 0.00645161 │          1.21079 │
└───────────────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────────────────────┬───────────────────┐
│                              variable │             value │
├───────────────────────────────────────┼───────────────────┤
│                               hullKey │ Stock/Bulk Hauler │
│                     OriginalPointCost │              1045 │
│                  WEAP-250mm Casemate  │              1801 │
│ MIS-Stock/Decoy Container (Line Ship) │                 2 │
│              MIS-Stock/Mine Container │                 4 │
│                          EWAR-Jammers │                 1 │
│                 PD-P20 'Bastion' PDT  │                 2 │
│                   PD-P60 'Grazer' PDT │                 2 │
│                            PD-Jammers │                 1 │
│            DEC-Stock/EA12 Chaff Decoy │                 9 │
│            DEC-Stock/EA20 Flare Decoy │                 7 │
│                         RestoresTotal │                 4 │
│                        DCTeamsCarried │                 6 │
└───────────────────────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  79 │   23 │  0.479 │   0.139 │
│ Destroyed/Other │  19 │   44 │  0.115 │   0.267 │
│           Total │  98 │   67 │  0.594 │   0.406 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 44, 158 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│       Stock/Ocello Cruiser │   109 │
│ Stock/Axford Heavy Cruiser │    49 │
└────────────────────────────┴───────┘


### Components

┌──────────────────────────┬───────────┬────────────┬──────────────────┐
│                    Names │   meanVal │ proportion │ scaledProportion │
├──────────────────────────┼───────────┼────────────┼──────────────────┤
│   PD-Mk95 'Sarissa' PDT  │   1.01899 │  0.0334928 │          6.56417 │
│     PD-Mk90 'Aurora' PDT │  0.778481 │  0.0302657 │           5.9317 │
│         WEAP-Beam Turret │  0.139241 │  0.0298507 │          5.85037 │
│          WEAP-250mm Gun  │   760.582 │   0.024712 │          4.84325 │
│          EWAR-Omnijammer │  0.189873 │  0.0238474 │          4.67378 │
│       WEAP-400mm Plasma  │   62.3165 │  0.0152731 │          2.99333 │
│ PD-Mk29 'Stonewall' PDT  │  0.848101 │  0.0150157 │          2.94288 │
│      WEAP-300mm Railgun  │   12.4684 │   0.014957 │          2.93138 │
│   PD-Mk25 'Rebound' PDT  │  0.658228 │  0.0146293 │          2.86717 │
│               PD-Jammers │ 0.0696203 │   0.011828 │          2.31813 │
│    MIS-Stock/S3 Net Mine │  0.253165 │   0.010926 │          2.14135 │
│           DCTeamsCarried │   7.74684 │  0.0100582 │          1.97128 │
│  PD-Mk20 'Defender' PDT  │   1.17722 │ 0.00946854 │          1.85571 │
│        OriginalPointCost │   1457.04 │ 0.00891906 │          1.74802 │
└──────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬────────────────────────────┐
│                   variable │                      value │
├────────────────────────────┼────────────────────────────┤
│                    hullKey │ Stock/Axford Heavy Cruiser │
│          OriginalPointCost │                       1484 │
│            WEAP-250mm Gun  │                        800 │
│           WEAP-Beam Turret │                          1 │
│     PD-Mk95 'Sarissa' PDT  │                          2 │
│    PD-Mk20 'Defender' PDT  │                          4 │
│ DEC-Stock/EA12 Chaff Decoy │                         21 │
│              RestoresTotal │                          2 │
│             DCTeamsCarried │                          7 │
└────────────────────────────┴────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   32 │  57 │  0.361 │   0.203 │
│ Destroyed/Other │   51 │  18 │  0.114 │   0.323 │
│           Total │   75 │  83 │  0.525 │   0.475 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 45, 156 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Solomon Battleship │   156 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│                 PD-&lt;line │ 0.0576923 │   0.109756 │          21.7866 │
│             WEAP-450mm Gun  │    1259.9 │  0.0845972 │          16.7925 │
│    PD-Mk29 'Stonewall' PDT  │   3.45513 │  0.0603989 │          11.9892 │
│            WEAP-Beam Turret │  0.230769 │  0.0488467 │          9.69607 │
│ DEC-Stock/EA99 Active Decoy │   2.96154 │  0.0329318 │          6.53696 │
│     PD-Mk20 'Defender' PDT  │    3.0641 │  0.0243331 │          4.83013 │
│      PD-Mk25 'Rebound' PDT  │  0.878205 │  0.0192713 │          3.82536 │
│               RestoresTotal │   8.38462 │  0.0182218 │          3.61703 │
│              DCTeamsCarried │   13.9359 │  0.0178648 │          3.54616 │
│           OriginalPointCost │   2633.46 │  0.0159163 │          3.15938 │
│      PD-Mk95 'Sarissa' PDT  │  0.314103 │  0.0101935 │           2.0234 │
│         WEAP-300mm Railgun  │       8.5 │  0.0100675 │           1.9984 │
│        PD-Mk90 'Aurora' PDT │  0.205128 │ 0.00787402 │          1.56299 │
│  DEC-Stock/EA12 Chaff Decoy │   3.85256 │ 0.00649716 │          1.28969 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬──────────────────────────┐
│                    variable │                    value │
├─────────────────────────────┼──────────────────────────┤
│                     hullKey │ Stock/Solomon Battleship │
│           OriginalPointCost │                     2590 │
│             WEAP-450mm Gun  │                     1186 │
│      PD-Mk95 'Sarissa' PDT  │                        2 │
│    PD-Mk29 'Stonewall' PDT  │                        4 │
│  DEC-Stock/EA12 Chaff Decoy │                        5 │
│ DEC-Stock/EA99 Active Decoy │                        4 │
│               RestoresTotal │                        7 │
│              DCTeamsCarried │                       12 │
└─────────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  55 │   37 │  0.353 │   0.237 │
│ Destroyed/Other │  12 │   52 │  0.077 │   0.333 │
│           Total │  67 │   89 │  0.429 │   0.571 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 46, 152 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │   152 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│               PD-250mm Gun  │   3.61184 │  0.0557587 │          11.3594 │
│      PD-Mk25 'Rebound' PDT  │   1.41447 │  0.0302434 │          6.16129 │
│             WEAP-250mm Gun  │   752.086 │   0.023508 │          4.78914 │
│     PD-Mk20 'Defender' PDT  │   2.20395 │  0.0170536 │          3.47421 │
│ DEC-Stock/EA99 Active Decoy │   1.48026 │  0.0160382 │          3.26736 │
│              DCTeamsCarried │   6.73026 │ 0.00840647 │           1.7126 │
│  DEC-Stock/EA20 Flare Decoy │   1.57895 │ 0.00773445 │          1.57569 │
│      MIS-Stock/SGM-H-3 Body │   1.28289 │ 0.00767777 │          1.56414 │
│               RestoresTotal │   3.48026 │ 0.00736954 │          1.50135 │
│                EWAR-Jammers │  0.493421 │ 0.00733496 │          1.49431 │
│  DEC-Stock/EA12 Chaff Decoy │   4.10526 │  0.0067458 │          1.37428 │
│           OriginalPointCost │   1046.65 │ 0.00616363 │          1.25568 │
│      MIS-Stock/SGM-H-2 Body │   1.73684 │ 0.00613041 │          1.24891 │
│             EWAR-Omnijammer │ 0.0394737 │ 0.00476948 │         0.971655 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────────────┐
│                variable │                        value │
├─────────────────────────┼──────────────────────────────┤
│                 hullKey │ Stock/Vauxhall Light Cruiser │
│       OriginalPointCost │                         1069 │
│         WEAP-250mm Gun  │                          800 │
│  PD-Mk25 'Rebound' PDT  │                            2 │
│ PD-Mk20 'Defender' PDT  │                            3 │
│           PD-250mm Gun  │                            5 │
│           RestoresTotal │                            5 │
│          DCTeamsCarried │                            8 │
└─────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   24 │  41 │   0.27 │   0.158 │
│ Destroyed/Other │   72 │  15 │  0.099 │   0.474 │
│           Total │   56 │  96 │  0.632 │   0.368 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 47, 145 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │   145 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│      MIS-Stock/SGM-H-2 Body │  53.9724 │    0.18173 │          38.8099 │
│      MIS-Stock/SGM-H-3 Body │  15.5793 │   0.088944 │          18.9948 │
│ DEC-Stock/EA99 Active Decoy │  3.13103 │  0.0323615 │          6.91109 │
│           OriginalPointCost │  2919.79 │  0.0164025 │          3.50291 │
│      PD-Mk25 'Rebound' PDT  │      0.6 │   0.012238 │          2.61353 │
│        MIS-Stock/SGM-1 Body │  3.75862 │  0.0099638 │          2.12786 │
│        MIS-Stock/SGM-2 Body │  11.4414 │ 0.00989579 │          2.11333 │
│     PD-Mk20 'Defender' PDT  │  1.24828 │ 0.00921401 │          1.96773 │
│  DEC-Stock/EA20 Flare Decoy │  1.89655 │ 0.00886239 │          1.89264 │
│  DEC-Stock/EA12 Chaff Decoy │  5.55172 │ 0.00870251 │           1.8585 │
│              DCTeamsCarried │  6.68276 │ 0.00796273 │          1.70051 │
│               RestoresTotal │  3.89655 │ 0.00787105 │          1.68093 │
│        PD-Mk90 'Aurora' PDT │ 0.165517 │ 0.00590551 │          1.26117 │
│                EWAR-Jammers │ 0.351724 │ 0.00498778 │          1.06518 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────────────┐
│                variable │                        value │
├─────────────────────────┼──────────────────────────────┤
│                 hullKey │ Stock/Vauxhall Light Cruiser │
│       OriginalPointCost │                         2849 │
│  MIS-Stock/SGM-H-3 Body │                           29 │
│  PD-Mk25 'Rebound' PDT  │                            2 │
│ PD-Mk20 'Defender' PDT  │                            2 │
│           RestoresTotal │                            3 │
│          DCTeamsCarried │                            5 │
└─────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   67 │  13 │   0.09 │   0.462 │
│   NotEliminated │   18 │  47 │  0.324 │   0.124 │
│           Total │   60 │  85 │  0.586 │   0.414 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 48, 144 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Feeder │   144 │
└───────────────────┴───────┘


### Components

┌────────────────────────────┬────────────┬────────────┬──────────────────┐
│                      Names │    meanVal │ proportion │ scaledProportion │
├────────────────────────────┼────────────┼────────────┼──────────────────┤
│         WEAP-400mm Plasma  │    684.299 │   0.152854 │          32.8699 │
│     WEAP-TE45 Mass Driver  │    59.0139 │  0.0198274 │          4.26372 │
│       PD-P11 'Pavise' PDT  │   0.555556 │  0.0106397 │          2.28798 │
│      PD-P20 'Bastion' PDT  │   0.701389 │  0.0085557 │          1.83983 │
│            EWAR-Omnijammer │  0.0694444 │ 0.00794913 │          1.70939 │
│        PD-P60 'Grazer' PDT │   0.291667 │  0.0070458 │          1.51514 │
│              RestoresTotal │    3.38194 │ 0.00678443 │          1.45894 │
│             DCTeamsCarried │     3.1875 │ 0.00377182 │         0.811098 │
│          OriginalPointCost │    606.028 │ 0.00338101 │         0.727058 │
│          EWAR-Illuminators │  0.0416667 │ 0.00330761 │         0.711273 │
│       WEAP-450mm Casemate  │    21.9444 │ 0.00278341 │         0.598549 │
│ DEC-Stock/EA12 Chaff Decoy │    1.15972 │ 0.00180537 │         0.388229 │
│            WEAP-100mm Gun  │    63.9306 │ 0.00131171 │         0.282071 │
│                 PD-Jammers │ 0.00694444 │ 0.00107527 │         0.231228 │
└────────────────────────────┴────────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────┬───────────────────┐
│             variable │             value │
├──────────────────────┼───────────────────┤
│              hullKey │ Stock/Bulk Feeder │
│    OriginalPointCost │               606 │
│   WEAP-400mm Plasma  │               625 │
│ PD-P11 'Pavise' PDT  │                 2 │
│        RestoresTotal │                 7 │
│       DCTeamsCarried │                 5 │
└──────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  47 │   25 │  0.326 │   0.174 │
│ Destroyed/Other │  15 │   57 │  0.104 │   0.396 │
│           Total │  62 │   82 │  0.431 │   0.569 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 49, 140 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│ Stock/Axford Heavy Cruiser │   124 │
│       Stock/Ocello Cruiser │    16 │
└────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│            WEAP-Beam Turret │ 0.585714 │   0.111262 │          24.6095 │
│      MIS-Stock/SGM-H-2 Body │  31.9357 │   0.103822 │           22.964 │
│      MIS-Stock/SGM-H-3 Body │  14.9286 │  0.0822899 │          18.2014 │
│        MIS-Stock/SGT-3 Body │  5.82143 │  0.0627357 │          13.8762 │
│ DEC-Stock/EA99 Active Decoy │  2.73571 │  0.0273006 │           6.0385 │
│        MIS-Stock/SGM-2 Body │  32.2929 │  0.0269674 │           5.9648 │
│    PD-Mk29 'Stonewall' PDT  │     1.45 │  0.0227476 │          5.03145 │
│        PD-Mk90 'Aurora' PDT │ 0.564286 │   0.019439 │          4.29962 │
│     PD-Mk20 'Defender' PDT  │  2.23571 │  0.0159336 │          3.52429 │
│           OriginalPointCost │  2906.16 │   0.015763 │          3.48655 │
│           EWAR-Illuminators │ 0.171429 │  0.0132304 │          2.92638 │
│              DCTeamsCarried │  7.93571 │ 0.00912961 │          2.01934 │
│  DEC-Stock/EA12 Chaff Decoy │  5.57143 │ 0.00843225 │          1.86509 │
│               RestoresTotal │  4.16429 │ 0.00812181 │          1.79643 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬────────────────────────────┐
│                    variable │                      value │
├─────────────────────────────┼────────────────────────────┤
│                     hullKey │ Stock/Axford Heavy Cruiser │
│           OriginalPointCost │                       2832 │
│        MIS-Stock/SGM-2 Body │                         64 │
│        MIS-Stock/SGT-3 Body │                         36 │
│                EWAR-Jammers │                          3 │
│    PD-Mk29 'Stonewall' PDT  │                          4 │
│  DEC-Stock/EA12 Chaff Decoy │                          8 │
│  DEC-Stock/EA20 Flare Decoy │                          8 │
│ DEC-Stock/EA99 Active Decoy │                          7 │
│               RestoresTotal │                         10 │
│              DCTeamsCarried │                         15 │
└─────────────────────────────┴────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  41 │   17 │  0.293 │   0.121 │
│ Destroyed/Other │  15 │   67 │  0.107 │   0.479 │
│           Total │  56 │   84 │    0.4 │     0.6 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 50, 140 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│       Stock/Ocello Cruiser │    78 │
│ Stock/Axford Heavy Cruiser │    62 │
└────────────────────────────┴───────┘


### Components

┌────────────────────────────┬───────────┬────────────┬──────────────────┐
│                      Names │   meanVal │ proportion │ scaledProportion │
├────────────────────────────┼───────────┼────────────┼──────────────────┤
│            WEAP-250mm Gun  │   1312.05 │  0.0377732 │          8.35489 │
│       PD-Mk90 'Aurora' PDT │  0.885714 │  0.0305118 │          6.74878 │
│           WEAP-Beam Turret │  0.142857 │   0.027137 │          6.00233 │
│     PD-Mk25 'Rebound' PDT  │   1.07143 │     0.0211 │          4.66702 │
│   PD-Mk29 'Stonewall' PDT  │   1.27857 │  0.0200583 │           4.4366 │
│            EWAR-Omnijammer │  0.178571 │  0.0198728 │          4.39558 │
│     PD-Mk95 'Sarissa' PDT  │  0.628571 │  0.0183066 │          4.04917 │
│             DCTeamsCarried │   8.20714 │ 0.00944187 │          2.08841 │
│       PD-P11 'Pavise' PDT  │  0.485714 │ 0.00904376 │          2.00035 │
│              RestoresTotal │   4.60714 │ 0.00898554 │          1.98747 │
│                 PD-Jammers │ 0.0571429 │ 0.00860215 │          1.90267 │
│    PD-Mk20 'Defender' PDT  │   1.17857 │ 0.00839951 │          1.85785 │
│          OriginalPointCost │   1503.01 │ 0.00815234 │          1.80318 │
│ DEC-Stock/EA20 Flare Decoy │   1.62857 │ 0.00734773 │          1.62521 │
└────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────┐
│                 variable │                value │
├──────────────────────────┼──────────────────────┤
│                  hullKey │ Stock/Ocello Cruiser │
│        OriginalPointCost │                 1500 │
│          WEAP-250mm Gun  │                 1250 │
│          EWAR-Omnijammer │                    2 │
│  PD-Mk20 'Defender' PDT  │                    2 │
│ PD-Mk29 'Stonewall' PDT  │                    2 │
│     PD-Mk90 'Aurora' PDT │                    2 │
│            RestoresTotal │                    3 │
│           DCTeamsCarried │                    5 │
└──────────────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   44 │  20 │  0.143 │   0.314 │
│   NotEliminated │   29 │  47 │  0.336 │   0.207 │
│           Total │   67 │  73 │  0.521 │   0.479 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 51, 137 hulls

### Hull Counts

┌──────────────────────┬───────┐
│                Hulls │ Count │
├──────────────────────┼───────┤
│ Stock/Raines Frigate │   137 │
└──────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬─────────────┬──────────────────┐
│                       Names │   meanVal │  proportion │ scaledProportion │
├─────────────────────────────┼───────────┼─────────────┼──────────────────┤
│             WEAP-120mm Gun  │   2461.31 │   0.0838321 │          18.9485 │
│               PD-120mm Gun  │   3.15328 │   0.0665742 │          15.0477 │
│              DCTeamsCarried │   2.54745 │   0.0028679 │         0.648228 │
│ DEC-Stock/EA99 Active Decoy │  0.262774 │  0.00256611 │         0.580016 │
│           OriginalPointCost │   384.504 │  0.00204086 │         0.461293 │
│                EWAR-Jammers │  0.124088 │  0.00166259 │         0.375794 │
│               RestoresTotal │   0.80292 │  0.00153242 │         0.346371 │
│               PD-250mm Gun  │ 0.0875912 │  0.00121877 │         0.275477 │
│     PD-Mk20 'Defender' PDT  │  0.153285 │  0.00106903 │         0.241632 │
│    PD-Mk29 'Stonewall' PDT  │ 0.0656934 │  0.00100852 │         0.227954 │
│             WEAP-250mm Gun  │   30.6569 │ 0.000863684 │         0.195218 │
│  DEC-Stock/EA12 Chaff Decoy │  0.467153 │ 0.000691877 │         0.156384 │
│        MIS-Stock/SGM-2 Body │  0.467153 │ 0.000381755 │        0.0862877 │
│      MIS-Stock/SGM-H-2 Body │ 0.0875912 │ 0.000278655 │        0.0629842 │
└─────────────────────────────┴───────────┴─────────────┴──────────────────┘


### Exemplar

┌───────────────────┬──────────────────────┐
│          variable │                value │
├───────────────────┼──────────────────────┤
│           hullKey │ Stock/Raines Frigate │
│ OriginalPointCost │                  405 │
│   WEAP-120mm Gun  │                 2500 │
│     PD-120mm Gun  │                    4 │
│    DCTeamsCarried │                    1 │
└───────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  70 │    9 │  0.511 │   0.066 │
│ Destroyed/Other │  23 │   35 │  0.168 │   0.255 │
│           Total │  93 │   44 │  0.679 │   0.321 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 52, 129 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │   129 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│             WEAP-250mm Gun  │  3010.52 │  0.0798613 │          19.1704 │
│               PD-250mm Gun  │  4.51163 │  0.0591103 │          14.1892 │
│ DEC-Stock/EA99 Active Decoy │   2.4186 │  0.0222396 │          5.33855 │
│     PD-Mk20 'Defender' PDT  │  2.47287 │  0.0162391 │          3.89813 │
│      PD-Mk25 'Rebound' PDT  │ 0.806202 │  0.0146293 │          3.51172 │
│  DEC-Stock/EA20 Flare Decoy │  2.87597 │  0.0119562 │          2.87004 │
│        PD-Mk90 'Aurora' PDT │ 0.255814 │ 0.00812008 │           1.9492 │
│              DCTeamsCarried │  6.89922 │ 0.00731355 │          1.75559 │
│               RestoresTotal │  3.71318 │ 0.00667298 │          1.60183 │
│      MIS-Stock/SGM-H-3 Body │  1.15504 │  0.0058666 │          1.40826 │
│           OriginalPointCost │  1169.26 │ 0.00584377 │          1.40278 │
│  DEC-Stock/EA12 Chaff Decoy │  4.07752 │ 0.00568636 │          1.36499 │
│      MIS-Stock/SGM-H-2 Body │  1.79845 │ 0.00538733 │          1.29321 │
│                EWAR-Jammers │ 0.286822 │ 0.00361858 │         0.868628 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────────────┐
│                variable │                        value │
├─────────────────────────┼──────────────────────────────┤
│                 hullKey │ Stock/Vauxhall Light Cruiser │
│       OriginalPointCost │                         1157 │
│         WEAP-250mm Gun  │                         2950 │
│            EWAR-Jammers │                            2 │
│ PD-Mk20 'Defender' PDT  │                            2 │
│           PD-250mm Gun  │                            6 │
│           RestoresTotal │                            4 │
│          DCTeamsCarried │                            7 │
└─────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  49 │   15 │   0.38 │   0.116 │
│ Destroyed/Other │  15 │   50 │  0.116 │   0.388 │
│           Total │  64 │   65 │  0.496 │   0.504 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 53, 127 hulls

### Hull Counts

┌────────────────────────┬───────┐
│                  Hulls │ Count │
├────────────────────────┼───────┤
│      Stock/Bulk Hauler │    96 │
│   Stock/Raines Frigate │    25 │
│ Stock/Container Hauler │     6 │
└────────────────────────┴───────┘


### Components

┌───────────────────────────────────────┬───────────┬────────────┬──────────────────┐
│                                 Names │   meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼───────────┼────────────┼──────────────────┤
│                  MIS-Stock/SGT-3 Body │   9.22835 │  0.0902163 │          21.9972 │
│                  MIS-Stock/SGM-1 Body │   38.5906 │  0.0896011 │          21.8471 │
│                  MIS-Stock/SGM-2 Body │   50.7165 │    0.03842 │          9.36783 │
│                     EWAR-Illuminators │  0.519685 │  0.0363837 │          8.87132 │
│                   MIS-Stock/S1 Rocket │   24.7874 │   0.035112 │          8.56124 │
│                MIS-Stock/SGM-H-2 Body │   8.48031 │  0.0250093 │          6.09793 │
│                  PD-P11 'Pavise' PDT  │   1.13386 │  0.0191515 │          4.66964 │
│ MIS-Stock/Decoy Container (Line Ship) │  0.346457 │  0.0185029 │          4.51151 │
│                   MIS-Stock/CM-4 Body │   7.29134 │   0.013374 │          3.26093 │
│                   PD-P60 'Grazer' PDT │  0.582677 │   0.012414 │          3.02687 │
│   MIS-Stock/Decoy Container (Clipper) │  0.173228 │  0.0099278 │          2.42066 │
│                         RestoresTotal │    4.8189 │ 0.00852581 │          2.07882 │
│                 MIS-Stock/S3 Net Mine │   0.23622 │ 0.00819448 │          1.99803 │
│                 PD-P20 'Bastion' PDT  │  0.755906 │ 0.00813215 │          1.98284 │
│                       EWAR-Omnijammer │ 0.0787402 │ 0.00794913 │          1.93821 │
└───────────────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────┬───────────────────┐
│             variable │             value │
├──────────────────────┼───────────────────┤
│              hullKey │ Stock/Bulk Hauler │
│    OriginalPointCost │              1637 │
│ MIS-Stock/SGM-2 Body │                64 │
│         EWAR-Jammers │                 1 │
│  PD-P60 'Grazer' PDT │                 1 │
│ PD-P11 'Pavise' PDT  │                 4 │
│        RestoresTotal │                 4 │
│       DCTeamsCarried │                 8 │
└──────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   56 │  17 │  0.134 │   0.441 │
│   NotEliminated │   11 │  43 │  0.339 │   0.087 │
│           Total │   60 │  67 │  0.528 │   0.472 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 54, 127 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Keystone Destroyer │   127 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│      MIS-Stock/SGM-H-2 Body │   28.2598 │  0.0833411 │          20.3208 │
│      WEAP-Mk600 Beam Cannon │  0.417323 │  0.0372453 │          9.08139 │
│      MIS-Stock/SGM-H-3 Body │   6.52756 │  0.0326404 │          7.95859 │
│ DEC-Stock/EA99 Active Decoy │   1.02362 │ 0.00926652 │          2.25943 │
│         WEAP-Mk550 Railgun  │   11.4882 │ 0.00836122 │          2.03869 │
│           OriginalPointCost │   1425.18 │ 0.00701237 │           1.7098 │
│        MIS-Stock/SGM-2 Body │    8.3937 │  0.0063586 │           1.5504 │
│  DEC-Stock/EA20 Flare Decoy │   1.37008 │ 0.00560748 │          1.36725 │
│        MIS-Stock/SGM-1 Body │   2.34646 │  0.0054481 │          1.32839 │
│     PD-Mk20 'Defender' PDT  │  0.787402 │ 0.00509061 │          1.24123 │
│        PD-Mk90 'Aurora' PDT │  0.141732 │ 0.00442913 │          1.07994 │
│  DEC-Stock/EA12 Chaff Decoy │    3.2126 │ 0.00441072 │          1.07545 │
│                EWAR-Jammers │  0.314961 │ 0.00391198 │         0.953846 │
│           EWAR-Illuminators │ 0.0472441 │ 0.00330761 │         0.806483 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬──────────────────────────┐
│                    variable │                    value │
├─────────────────────────────┼──────────────────────────┤
│                     hullKey │ Stock/Keystone Destroyer │
│           OriginalPointCost │                     1401 │
│      WEAP-Mk600 Beam Cannon │                        1 │
│        MIS-Stock/SGM-1 Body │                        4 │
│      MIS-Stock/SGM-H-2 Body │                       40 │
│        MIS-Stock/SGM-2 Body │                        8 │
│     PD-Mk20 'Defender' PDT  │                        2 │
│  DEC-Stock/EA12 Chaff Decoy │                        5 │
│  DEC-Stock/EA20 Flare Decoy │                        5 │
│ DEC-Stock/EA99 Active Decoy │                        3 │
│               RestoresTotal │                        2 │
│              DCTeamsCarried │                        4 │
└─────────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  29 │   17 │  0.228 │   0.134 │
│ Destroyed/Other │  15 │   66 │  0.118 │    0.52 │
│           Total │  44 │   83 │  0.346 │   0.654 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 55, 121 hulls

### Hull Counts

┌──────────────────────┬───────┐
│                Hulls │ Count │
├──────────────────────┼───────┤
│ Stock/Raines Frigate │   121 │
└──────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬─────────────┬──────────────────┐
│                       Names │   meanVal │  proportion │ scaledProportion │
├─────────────────────────────┼───────────┼─────────────┼──────────────────┤
│             WEAP-250mm Gun  │   1235.67 │   0.0307463 │          7.86852 │
│               PD-250mm Gun  │   1.71901 │   0.0211253 │          5.40634 │
│    PD-Mk29 'Stonewall' PDT  │  0.479339 │  0.00649933 │          1.66329 │
│ DEC-Stock/EA99 Active Decoy │  0.495868 │  0.00427686 │          1.09452 │
│      PD-Mk95 'Sarissa' PDT  │   0.14876 │  0.00374454 │         0.958293 │
│                EWAR-Jammers │  0.280992 │  0.00332518 │         0.850972 │
│           EWAR-Illuminators │ 0.0495868 │  0.00330761 │         0.846474 │
│     PD-Mk20 'Defender' PDT  │  0.528926 │  0.00325799 │         0.833777 │
│              DCTeamsCarried │   2.55372 │   0.0025392 │         0.649825 │
│  DEC-Stock/EA12 Chaff Decoy │   1.77686 │  0.00232427 │         0.594822 │
│           OriginalPointCost │   457.669 │   0.0021455 │         0.549071 │
│               RestoresTotal │   1.06612 │  0.00179711 │         0.459911 │
│        MIS-Stock/SGM-1 Body │  0.694215 │  0.00153571 │         0.393014 │
│      PD-Mk25 'Rebound' PDT  │ 0.0495868 │ 0.000844001 │         0.215994 │
└─────────────────────────────┴───────────┴─────────────┴──────────────────┘


### Exemplar

┌───────────────────┬──────────────────────┐
│          variable │                value │
├───────────────────┼──────────────────────┤
│           hullKey │ Stock/Raines Frigate │
│ OriginalPointCost │                  454 │
│   WEAP-250mm Gun  │                 1200 │
│      EWAR-Jammers │                    2 │
│     PD-250mm Gun  │                    2 │
│     RestoresTotal │                    1 │
│    DCTeamsCarried │                    3 │
└───────────────────┴──────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   15 │  46 │   0.38 │   0.124 │
│ Destroyed/Other │   41 │  19 │  0.157 │   0.339 │
│           Total │   65 │  56 │  0.463 │   0.537 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 56, 117 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │   117 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│               PD-250mm Gun  │   3.7094 │  0.0440788 │          11.6662 │
│             WEAP-250mm Gun  │  1266.03 │  0.0304603 │          8.06182 │
│      MIS-Stock/SGM-H-3 Body │  5.57265 │  0.0256713 │          6.79434 │
│      MIS-Stock/SGM-H-2 Body │  7.88889 │  0.0214332 │          5.67266 │
│ DEC-Stock/EA99 Active Decoy │  1.98291 │  0.0165372 │          4.37684 │
│     PD-Mk20 'Defender' PDT  │  2.36752 │   0.014101 │          3.73206 │
│      PD-Mk25 'Rebound' PDT  │ 0.846154 │   0.013926 │          3.68575 │
│              DCTeamsCarried │  7.77778 │  0.0074779 │          1.97915 │
│               RestoresTotal │  4.36752 │ 0.00711878 │           1.8841 │
│           OriginalPointCost │  1497.09 │ 0.00678615 │          1.79607 │
│  DEC-Stock/EA20 Flare Decoy │  1.41026 │ 0.00531743 │          1.40735 │
│        PD-Mk90 'Aurora' PDT │ 0.153846 │ 0.00442913 │          1.17224 │
│  DEC-Stock/EA12 Chaff Decoy │  3.10256 │ 0.00392424 │          1.03862 │
│                EWAR-Jammers │ 0.282051 │ 0.00322738 │         0.854181 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────────────┐
│                variable │                        value │
├─────────────────────────┼──────────────────────────────┤
│                 hullKey │ Stock/Vauxhall Light Cruiser │
│       OriginalPointCost │                         1500 │
│         WEAP-250mm Gun  │                         1250 │
│  MIS-Stock/SGM-H-3 Body │                            6 │
│            EWAR-Jammers │                            1 │
│ PD-Mk20 'Defender' PDT  │                            4 │
│           PD-250mm Gun  │                            4 │
│           RestoresTotal │                            7 │
│          DCTeamsCarried │                           12 │
└─────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   13 │  32 │  0.274 │   0.111 │
│ Destroyed/Other │   55 │  17 │  0.145 │    0.47 │
│           Total │   49 │  68 │  0.581 │   0.419 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 57, 115 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Keystone Destroyer │   115 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│      WEAP-Mk600 Beam Cannon │ 0.852174 │  0.0688686 │          18.5442 │
│               PD-120mm Gun  │  2.22609 │  0.0394514 │          10.6231 │
│             WEAP-120mm Gun  │  1206.71 │  0.0345005 │          9.28994 │
│         WEAP-Mk550 Railgun  │  23.4609 │  0.0154617 │          4.16336 │
│ DEC-Stock/EA99 Active Decoy │  1.72174 │  0.0141136 │          3.80037 │
│      PD-Mk25 'Rebound' PDT  │ 0.643478 │  0.0104093 │          2.80292 │
│     PD-Mk20 'Defender' PDT  │  1.17391 │ 0.00687233 │          1.85051 │
│              DCTeamsCarried │  5.06087 │ 0.00478257 │           1.2878 │
│  DEC-Stock/EA12 Chaff Decoy │  3.45217 │  0.0042918 │          1.15565 │
│               RestoresTotal │  2.65217 │ 0.00424898 │          1.14412 │
│    PD-Mk29 'Stonewall' PDT  │ 0.304348 │ 0.00392201 │          1.05608 │
│        PD-Mk90 'Aurora' PDT │ 0.121739 │ 0.00344488 │         0.927602 │
│           OriginalPointCost │  704.809 │ 0.00314022 │         0.845566 │
│                EWAR-Jammers │  0.26087 │ 0.00293399 │         0.790033 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────────┐
│                variable │                    value │
├─────────────────────────┼──────────────────────────┤
│                 hullKey │ Stock/Keystone Destroyer │
│       OriginalPointCost │                      703 │
│         WEAP-120mm Gun  │                     1200 │
│  WEAP-Mk600 Beam Cannon │                        1 │
│           PD-120mm Gun  │                        2 │
│ PD-Mk20 'Defender' PDT  │                        3 │
│           RestoresTotal │                        5 │
│          DCTeamsCarried │                        8 │
└─────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  37 │   10 │  0.322 │   0.087 │
│ Destroyed/Other │  25 │   43 │  0.217 │   0.374 │
│           Total │  62 │   53 │  0.539 │   0.461 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 58, 111 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Solomon Battleship │   111 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│            WEAP-Beam Turret │ 0.261261 │  0.0393487 │          10.9772 │
│             WEAP-450mm Gun  │  716.261 │  0.0342207 │          9.54664 │
│    PD-Mk29 'Stonewall' PDT  │  2.28829 │  0.0284626 │          7.94029 │
│ DEC-Stock/EA99 Active Decoy │  3.07207 │  0.0243068 │          6.78094 │
│      PD-Mk95 'Sarissa' PDT  │ 0.963964 │  0.0222592 │          6.20972 │
│           EWAR-Illuminators │  0.36036 │  0.0220507 │          6.15155 │
│         WEAP-300mm Railgun  │  25.4054 │  0.0214105 │          5.97295 │
│        PD-Mk90 'Aurora' PDT │ 0.612613 │  0.0167323 │          4.66785 │
│      MIS-Stock/SGM-H-3 Body │  3.23423 │   0.014135 │          3.94327 │
│     PD-Mk20 'Defender' PDT  │   2.2973 │  0.0129811 │          3.62137 │
│           OriginalPointCost │  2853.41 │  0.0122709 │          3.42326 │
│              DCTeamsCarried │  13.2703 │  0.0121043 │          3.37678 │
│               RestoresTotal │  7.81081 │  0.0120782 │           3.3695 │
│      PD-Mk25 'Rebound' PDT  │ 0.576577 │ 0.00900267 │           2.5115 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬──────────────────────────┐
│                   variable │                    value │
├────────────────────────────┼──────────────────────────┤
│                    hullKey │ Stock/Solomon Battleship │
│          OriginalPointCost │                     2865 │
│            WEAP-450mm Gun  │                      700 │
│        WEAP-300mm Railgun  │                       60 │
│     MIS-Stock/SGM-H-3 Body │                        8 │
│               EWAR-Jammers │                        1 │
│     PD-Mk25 'Rebound' PDT  │                        6 │
│ DEC-Stock/EA12 Chaff Decoy │                       16 │
│ DEC-Stock/EA20 Flare Decoy │                        7 │
│              RestoresTotal │                        6 │
│             DCTeamsCarried │                        9 │
└────────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   21 │  41 │  0.369 │   0.189 │
│ Destroyed/Other │   43 │   6 │  0.054 │   0.387 │
│           Total │   47 │  64 │  0.577 │   0.423 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 59, 107 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │   107 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│           EWAR-Illuminators │ 0.551402 │  0.0325248 │          9.41274 │
│      MIS-Stock/SGM-H-3 Body │  6.94393 │  0.0292543 │          8.46624 │
│        MIS-Stock/SGM-2 Body │  34.4766 │  0.0220046 │          6.36816 │
│        MIS-Stock/SGM-1 Body │  9.36449 │  0.0183188 │          5.30149 │
│ DEC-Stock/EA99 Active Decoy │  2.26168 │    0.01725 │          4.99218 │
│        PD-Mk90 'Aurora' PDT │ 0.560748 │  0.0147638 │          4.27267 │
│      PD-Mk25 'Rebound' PDT  │  0.71028 │  0.0106907 │           3.0939 │
│             EWAR-Omnijammer │  0.11215 │ 0.00953895 │          2.76059 │
│      MIS-Stock/SGM-H-2 Body │  3.71028 │ 0.00921884 │          2.66795 │
│               PD-250mm Gun  │ 0.831776 │  0.0090392 │          2.61596 │
│     PD-Mk20 'Defender' PDT  │  1.37383 │  0.0074832 │          2.16565 │
│  DEC-Stock/EA12 Chaff Decoy │  5.40187 │ 0.00624851 │          1.80833 │
│      PD-Mk95 'Sarissa' PDT  │ 0.261682 │ 0.00582484 │          1.68572 │
│           OriginalPointCost │  1373.81 │ 0.00569512 │          1.64818 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬──────────────────────────────┐
│                    variable │                        value │
├─────────────────────────────┼──────────────────────────────┤
│                     hullKey │ Stock/Vauxhall Light Cruiser │
│           OriginalPointCost │                         1465 │
│             WEAP-250mm Gun  │                          250 │
│      MIS-Stock/SGM-H-3 Body │                            6 │
│        MIS-Stock/SGM-2 Body │                           24 │
│      PD-Mk25 'Rebound' PDT  │                            4 │
│               PD-250mm Gun  │                            1 │
│  DEC-Stock/EA12 Chaff Decoy │                            8 │
│  DEC-Stock/EA20 Flare Decoy │                            4 │
│ DEC-Stock/EA99 Active Decoy │                            4 │
│               RestoresTotal │                            3 │
│              DCTeamsCarried │                            6 │
└─────────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   41 │  24 │  0.224 │   0.383 │
│   NotEliminated │   13 │  29 │  0.271 │   0.121 │
│           Total │   53 │  54 │  0.505 │   0.495 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 60, 103 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│ Stock/Axford Heavy Cruiser │    64 │
│       Stock/Ocello Cruiser │    39 │
└────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│            WEAP-Beam Turret │  0.330097 │   0.046133 │          13.8695 │
│             WEAP-250mm Gun  │   1976.37 │  0.0418611 │          12.5852 │
│    PD-Mk29 'Stonewall' PDT  │   1.78641 │  0.0206186 │          6.19878 │
│        PD-Mk90 'Aurora' PDT │  0.601942 │  0.0152559 │          4.58655 │
│      PD-Mk25 'Rebound' PDT  │  0.854369 │  0.0123787 │          3.72153 │
│     PD-Mk20 'Defender' PDT  │   2.05825 │  0.0107921 │          3.24455 │
│      PD-Mk95 'Sarissa' PDT  │  0.349515 │ 0.00748908 │          2.25152 │
│              DCTeamsCarried │   8.73786 │ 0.00739572 │          2.22346 │
│               RestoresTotal │   4.98058 │ 0.00714664 │          2.14857 │
│           OriginalPointCost │   1543.24 │ 0.00615833 │          1.85144 │
│             EWAR-Omnijammer │ 0.0582524 │ 0.00476948 │           1.4339 │
│  DEC-Stock/EA12 Chaff Decoy │   3.91262 │ 0.00435666 │          1.30979 │
│ DEC-Stock/EA99 Active Decoy │  0.592233 │ 0.00434814 │          1.30723 │
│  DEC-Stock/EA20 Flare Decoy │   1.07767 │ 0.00357718 │          1.07545 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬────────────────────────────┐
│                   variable │                      value │
├────────────────────────────┼────────────────────────────┤
│                    hullKey │ Stock/Axford Heavy Cruiser │
│          OriginalPointCost │                       1547 │
│            WEAP-250mm Gun  │                       2050 │
│           WEAP-Beam Turret │                          1 │
│               EWAR-Jammers │                          1 │
│     PD-Mk25 'Rebound' PDT  │                          1 │
│       PD-Mk90 'Aurora' PDT │                          2 │
│ DEC-Stock/EA12 Chaff Decoy │                         11 │
│              RestoresTotal │                          4 │
│             DCTeamsCarried │                          8 │
└────────────────────────────┴────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  12 │   34 │  0.117 │    0.33 │
│   NotEliminated │  40 │   17 │  0.388 │   0.165 │
│           Total │  52 │   51 │  0.505 │   0.495 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 61, 98 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │    98 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬───────────┬────────────┬──────────────────┐
│                                 Names │   meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼───────────┼────────────┼──────────────────┤
│                    WEAP-400mm Plasma  │   703.133 │   0.106888 │          33.7746 │
│                 PD-P20 'Bastion' PDT  │   2.18367 │  0.0181279 │          5.72805 │
│                  PD-P11 'Pavise' PDT  │   1.28571 │  0.0167575 │          5.29504 │
│ MIS-Stock/Decoy Container (Line Ship) │  0.367347 │  0.0151388 │          4.78354 │
│                            PD-Jammers │ 0.0918367 │ 0.00967742 │          3.05787 │
│                   PD-P60 'Grazer' PDT │  0.561224 │ 0.00922664 │          2.91543 │
│                         RestoresTotal │    5.9898 │ 0.00817754 │          2.58393 │
│            DEC-Stock/EA20 Flare Decoy │   2.38776 │ 0.00754109 │          2.38283 │
│              MIS-Stock/Mine Container │  0.306122 │ 0.00463679 │          1.46513 │
│                        DCTeamsCarried │   5.70408 │ 0.00459356 │          1.45147 │
│            DEC-Stock/EA12 Chaff Decoy │   4.28571 │ 0.00454044 │          1.43469 │
│                     OriginalPointCost │   1094.38 │ 0.00415513 │          1.31294 │
│                       EWAR-Omnijammer │ 0.0510204 │ 0.00397456 │          1.25588 │
│   MIS-Stock/Decoy Container (Clipper) │ 0.0816327 │ 0.00361011 │          1.14072 │
└───────────────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬───────────────────┐
│                   variable │             value │
├────────────────────────────┼───────────────────┤
│                    hullKey │ Stock/Bulk Hauler │
│          OriginalPointCost │              1137 │
│         WEAP-400mm Plasma  │               600 │
│       PD-P11 'Pavise' PDT  │                 4 │
│ DEC-Stock/EA12 Chaff Decoy │                 8 │
│ DEC-Stock/EA20 Flare Decoy │                 8 │
│              RestoresTotal │                10 │
│             DCTeamsCarried │                10 │
└────────────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  40 │    8 │  0.408 │   0.082 │
│ Destroyed/Other │  18 │   32 │  0.184 │   0.327 │
│           Total │  58 │   40 │  0.592 │   0.408 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 62, 97 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│ Stock/Axford Heavy Cruiser │    65 │
│       Stock/Ocello Cruiser │    32 │
└────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│               PD-120mm Gun  │  1.94845 │  0.0291262 │          9.29817 │
│             WEAP-120mm Gun  │  1102.65 │  0.0265909 │           8.4888 │
│             WEAP-450mm Gun  │  532.773 │  0.0222438 │          7.10103 │
│            WEAP-Beam Turret │  0.14433 │  0.0189959 │          6.06421 │
│        MIS-Stock/SGT-3 Body │  2.45361 │  0.0183204 │          5.84854 │
│        PD-Mk90 'Aurora' PDT │ 0.494845 │   0.011811 │          3.77052 │
│      PD-Mk25 'Rebound' PDT  │  0.71134 │ 0.00970601 │          3.09852 │
│     PD-Mk20 'Defender' PDT  │  1.56701 │ 0.00773773 │          2.47017 │
│         WEAP-300mm Railgun  │  8.24742 │  0.0060739 │          1.93902 │
│              DCTeamsCarried │  7.56701 │ 0.00603162 │          1.92552 │
│           OriginalPointCost │   1567.6 │ 0.00589112 │          1.88066 │
│               RestoresTotal │  4.25773 │ 0.00575353 │          1.83674 │
│ DEC-Stock/EA99 Active Decoy │ 0.639175 │ 0.00441942 │          1.41084 │
│      MIS-Stock/SGM-H-3 Body │  1.14433 │ 0.00437042 │           1.3952 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬────────────────────────────┐
│               variable │                      value │
├────────────────────────┼────────────────────────────┤
│                hullKey │ Stock/Axford Heavy Cruiser │
│      OriginalPointCost │                       1500 │
│        WEAP-120mm Gun  │                       1100 │
│        WEAP-450mm Gun  │                        500 │
│          PD-120mm Gun  │                          4 │
│ PD-Mk25 'Rebound' PDT  │                          3 │
│          RestoresTotal │                         10 │
│         DCTeamsCarried │                         15 │
└────────────────────────┴────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   14 │  25 │  0.258 │   0.144 │
│ Destroyed/Other │   44 │  14 │  0.144 │   0.454 │
│           Total │   39 │  58 │  0.598 │   0.402 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 63, 95 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│ Stock/Axford Heavy Cruiser │    87 │
│       Stock/Ocello Cruiser │     8 │
└────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│      MIS-Stock/SGM-H-2 Body │  35.8842 │  0.0791612 │          25.8032 │
│ DEC-Stock/EA99 Active Decoy │  5.49474 │  0.0372086 │          12.1284 │
│             WEAP-450mm Gun  │  567.705 │  0.0232135 │          7.56662 │
│      PD-Mk95 'Sarissa' PDT  │  1.15789 │  0.0228833 │          7.45899 │
│    PD-Mk29 'Stonewall' PDT  │  1.83158 │   0.019498 │          6.35552 │
│      MIS-Stock/SGM-H-3 Body │  4.12632 │  0.0154343 │          5.03093 │
│           OriginalPointCost │  2886.71 │  0.0106247 │          3.46321 │
│               RestoresTotal │  6.31579 │ 0.00835864 │          2.72457 │
│              DCTeamsCarried │  10.4526 │ 0.00815994 │           2.6598 │
│     PD-Mk20 'Defender' PDT  │  1.63158 │ 0.00789045 │          2.57195 │
│      PD-Mk25 'Rebound' PDT  │ 0.526316 │ 0.00703334 │          2.29257 │
│        PD-Mk90 'Aurora' PDT │ 0.284211 │  0.0066437 │          2.16557 │
│  DEC-Stock/EA20 Flare Decoy │  2.08421 │ 0.00638092 │          2.07991 │
│                EWAR-Jammers │ 0.642105 │ 0.00596577 │          1.94459 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬────────────────────────────┐
│                    variable │                      value │
├─────────────────────────────┼────────────────────────────┤
│                     hullKey │ Stock/Axford Heavy Cruiser │
│           OriginalPointCost │                       2797 │
│             WEAP-450mm Gun  │                        592 │
│      MIS-Stock/SGM-H-2 Body │                         64 │
│      PD-Mk25 'Rebound' PDT  │                          6 │
│  DEC-Stock/EA12 Chaff Decoy │                          2 │
│  DEC-Stock/EA20 Flare Decoy │                          2 │
│ DEC-Stock/EA99 Active Decoy │                          2 │
│               RestoresTotal │                          3 │
│              DCTeamsCarried │                          6 │
└─────────────────────────────┴────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   39 │   7 │  0.074 │   0.411 │
│   NotEliminated │   21 │  28 │  0.295 │   0.221 │
│           Total │   35 │  60 │  0.632 │   0.368 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 64, 93 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│     Stock/Tugboat │    74 │
│ Stock/Bulk Feeder │    19 │
└───────────────────┴───────┘


### Components

┌────────────────────────────┬───────────┬─────────────┬──────────────────┐
│                      Names │   meanVal │  proportion │ scaledProportion │
├────────────────────────────┼───────────┼─────────────┼──────────────────┤
│       WEAP-250mm Casemate  │   616.301 │   0.0287439 │          9.57078 │
│              PD-100mm Gun  │  0.870968 │    0.018737 │          6.23881 │
│            WEAP-100mm Gun  │   1383.95 │   0.0183387 │          6.10618 │
│      PD-P20 'Bastion' PDT  │  0.978495 │   0.0077086 │          2.56671 │
│        PD-P60 'Grazer' PDT │  0.473118 │  0.00738131 │          2.45774 │
│       PD-P11 'Pavise' PDT  │  0.462366 │  0.00571885 │          1.90419 │
│              RestoresTotal │   1.83871 │  0.00238221 │           0.7932 │
│                 PD-Jammers │ 0.0215054 │  0.00215054 │          0.71606 │
│             DCTeamsCarried │   2.44086 │  0.00186537 │         0.621106 │
│          OriginalPointCost │   362.753 │  0.00130703 │         0.435198 │
│               EWAR-Jammers │ 0.0645161 │ 0.000586797 │         0.195384 │
│ DEC-Stock/EA20 Flare Decoy │  0.172043 │  0.00051563 │         0.171688 │
│        MIS-Stock/S1 Rocket │  0.387097 │ 0.000401535 │         0.133698 │
│ DEC-Stock/EA12 Chaff Decoy │  0.387097 │ 0.000389181 │         0.129585 │
└────────────────────────────┴───────────┴─────────────┴──────────────────┘


### Exemplar

┌──────────────────────┬───────────────┐
│             variable │         value │
├──────────────────────┼───────────────┤
│              hullKey │ Stock/Tugboat │
│    OriginalPointCost │           315 │
│      WEAP-100mm Gun  │          1300 │
│ WEAP-250mm Casemate  │           600 │
│  PD-P60 'Grazer' PDT │             2 │
│        PD-100mm Gun  │             2 │
│        RestoresTotal │             1 │
│       DCTeamsCarried │             2 │
└──────────────────────┴───────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  54 │    9 │  0.581 │   0.097 │
│ Destroyed/Other │  19 │   11 │  0.204 │   0.118 │
│           Total │  73 │   20 │  0.785 │   0.215 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 65, 89 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Keystone Destroyer │    89 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│      WEAP-Mk600 Beam Cannon │ 0.831461 │  0.0520028 │          18.0935 │
│             WEAP-250mm Gun  │  1466.96 │   0.026848 │           9.3413 │
│               PD-250mm Gun  │  1.46067 │  0.0132033 │          4.59387 │
│         WEAP-Mk550 Railgun  │  24.9438 │  0.0127224 │          4.42652 │
│ DEC-Stock/EA99 Active Decoy │  1.13483 │ 0.00719937 │           2.5049 │
│    PD-Mk29 'Stonewall' PDT  │ 0.719101 │ 0.00717167 │          2.49526 │
│     PD-Mk20 'Defender' PDT  │  1.29213 │  0.0058542 │          2.03687 │
│        PD-Mk90 'Aurora' PDT │ 0.258427 │ 0.00565945 │          1.96911 │
│        MIS-Stock/SGT-3 Body │ 0.674157 │ 0.00461858 │          1.60696 │
│      PD-Mk95 'Sarissa' PDT  │ 0.235955 │ 0.00436863 │          1.51999 │
│               RestoresTotal │  3.20225 │ 0.00397035 │          1.38142 │
│              DCTeamsCarried │   5.2809 │ 0.00386221 │          1.34379 │
│      MIS-Stock/SGM-H-2 Body │  1.79775 │  0.0037154 │          1.29271 │
│  DEC-Stock/EA12 Chaff Decoy │  3.46067 │ 0.00332966 │           1.1585 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────────┐
│                 variable │                    value │
├──────────────────────────┼──────────────────────────┤
│                  hullKey │ Stock/Keystone Destroyer │
│        OriginalPointCost │                      822 │
│          WEAP-250mm Gun  │                     1465 │
│   WEAP-Mk600 Beam Cannon │                        1 │
│ PD-Mk29 'Stonewall' PDT  │                        2 │
│     PD-Mk90 'Aurora' PDT │                        1 │
│            PD-250mm Gun  │                        2 │
│            RestoresTotal │                        4 │
│           DCTeamsCarried │                        6 │
└──────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   64 │   4 │  0.045 │   0.719 │
│   NotEliminated │   12 │   9 │  0.101 │   0.135 │
│           Total │   13 │  76 │  0.854 │   0.146 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 66, 88 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │    88 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬───────────┬────────────┬──────────────────┐
│                                 Names │   meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼───────────┼────────────┼──────────────────┤
│                  WEAP-450mm Casemate  │    1706.5 │   0.132275 │          46.5459 │
│                  PD-P11 'Pavise' PDT  │   1.70455 │  0.0199495 │          7.01994 │
│                 PD-P20 'Bastion' PDT  │   2.47727 │  0.0184668 │           6.4982 │
│ MIS-Stock/Decoy Container (Line Ship) │  0.409091 │  0.0151388 │          5.32713 │
│                 MIS-Stock/S3 Net Mine │  0.556818 │  0.0133843 │          4.70976 │
│            DEC-Stock/EA20 Flare Decoy │   4.68182 │  0.0132775 │          4.67216 │
│              MIS-Stock/Mine Container │  0.886364 │  0.0120556 │          4.24222 │
│                       EWAR-Omnijammer │  0.159091 │  0.0111288 │          3.91606 │
│                   PD-P60 'Grazer' PDT │  0.670455 │ 0.00989767 │          3.48285 │
│            DEC-Stock/EA12 Chaff Decoy │   7.88636 │ 0.00750254 │          2.64004 │
│   MIS-Stock/Decoy Container (Clipper) │  0.181818 │ 0.00722022 │           2.5407 │
│                         RestoresTotal │      5.75 │ 0.00704912 │          2.48049 │
│                            PD-Jammers │ 0.0681818 │ 0.00645161 │          2.27023 │
│                    WEAP-400mm Plasma  │   33.2614 │ 0.00454036 │          1.59769 │
│                     OriginalPointCost │   1257.74 │ 0.00428809 │          1.50892 │
└───────────────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬───────────────────┐
│                   variable │             value │
├────────────────────────────┼───────────────────┤
│                    hullKey │ Stock/Bulk Hauler │
│          OriginalPointCost │              1275 │
│       WEAP-450mm Casemate  │              1650 │
│      PD-P20 'Bastion' PDT  │                 1 │
│        PD-P60 'Grazer' PDT │                 2 │
│       PD-P11 'Pavise' PDT  │                 2 │
│ DEC-Stock/EA12 Chaff Decoy │                21 │
│              RestoresTotal │                 6 │
│             DCTeamsCarried │                 4 │
└────────────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  23 │   17 │  0.261 │   0.193 │
│ Destroyed/Other │  19 │   29 │  0.216 │    0.33 │
│           Total │  42 │   46 │  0.477 │   0.523 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 67, 83 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Feeder │    81 │
│     Stock/Tugboat │     2 │
└───────────────────┴───────┘


### Components

┌────────────────────────────┬───────────┬────────────┬──────────────────┐
│                      Names │   meanVal │ proportion │ scaledProportion │
├────────────────────────────┼───────────┼────────────┼──────────────────┤
│          MIS-Stock/S3 Mine │   20.2651 │   0.389622 │          145.362 │
│   MIS-Stock/S3 Sprint Mine │   6.59036 │  0.0550302 │          20.5309 │
│      MIS-Stock/S3 Net Mine │   1.79518 │  0.0406993 │          15.1843 │
│       MIS-Stock/SGM-2 Body │   70.2289 │  0.0347695 │           12.972 │
│       MIS-Stock/SGT-3 Body │   2.24096 │  0.0143176 │          5.34167 │
│     WEAP-TE45 Mass Driver  │   24.7711 │ 0.00479702 │          1.78969 │
│          OriginalPointCost │   1457.37 │ 0.00468641 │          1.74843 │
│          EWAR-Illuminators │ 0.0843373 │ 0.00385888 │          1.43969 │
│              RestoresTotal │   2.90361 │ 0.00335739 │          1.25259 │
│        MIS-Stock/S1 Rocket │   3.03614 │ 0.00281074 │          1.04864 │
│             DCTeamsCarried │    3.3494 │ 0.00228446 │         0.852295 │
│                 PD-Jammers │ 0.0240964 │ 0.00215054 │         0.802332 │
│       PD-P11 'Pavise' PDT  │  0.180723 │ 0.00199495 │         0.744283 │
│         WEAP-400mm Plasma  │   14.4578 │ 0.00186144 │         0.694473 │
│ DEC-Stock/EA20 Flare Decoy │  0.650602 │ 0.00174025 │         0.649261 │
└────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────┬───────────────────┐
│             variable │             value │
├──────────────────────┼───────────────────┤
│              hullKey │ Stock/Bulk Feeder │
│    OriginalPointCost │              1468 │
│ MIS-Stock/SGM-2 Body │                42 │
│         EWAR-Jammers │                 1 │
│    EWAR-Illuminators │                 1 │
│           PD-Jammers │                 1 │
│        RestoresTotal │                 2 │
│       DCTeamsCarried │                 3 │
└──────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  35 │    6 │  0.422 │   0.072 │
│ Destroyed/Other │  13 │   29 │  0.157 │   0.349 │
│           Total │  48 │   35 │  0.578 │   0.422 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 68, 79 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │    79 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬──────────┬────────────┬──────────────────┐
│                                 Names │  meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼──────────┼────────────┼──────────────────┤
│                    WEAP-400mm Plasma  │  365.759 │  0.0448219 │           17.569 │
│ MIS-Stock/Decoy Container (Line Ship) │ 0.962025 │  0.0319596 │          12.5274 │
│                         PD-100mm Gun  │ 0.734177 │  0.0134166 │          5.25897 │
│                       WEAP-100mm Gun  │  1087.14 │  0.0122371 │          4.79662 │
│                WEAP-TE45 Mass Driver  │  54.4304 │  0.0100327 │          3.93256 │
│                 MIS-Stock/S3 Net Mine │  0.43038 │ 0.00928708 │           3.6403 │
│                  PD-P11 'Pavise' PDT  │ 0.860759 │ 0.00904376 │          3.54492 │
│                  WEAP-450mm Casemate  │  93.6203 │ 0.00651458 │          2.55355 │
│                         RestoresTotal │  5.89873 │ 0.00649188 │          2.54465 │
│            DEC-Stock/EA20 Flare Decoy │  2.40506 │ 0.00612311 │           2.4001 │
│                 PD-P20 'Bastion' PDT  │ 0.708861 │ 0.00474375 │          1.85943 │
│            DEC-Stock/EA12 Chaff Decoy │  5.50633 │  0.0047026 │           1.8433 │
│                        DCTeamsCarried │  5.62025 │ 0.00364856 │          1.43014 │
│                  MIS-Stock/SGM-2 Body │  7.18987 │ 0.00338807 │          1.32804 │
│                     OriginalPointCost │  1092.27 │ 0.00334308 │           1.3104 │
└───────────────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────────┐
│              variable │             value │
├───────────────────────┼───────────────────┤
│               hullKey │ Stock/Bulk Hauler │
│     OriginalPointCost │              1160 │
│       WEAP-100mm Gun  │              1000 │
│    WEAP-400mm Plasma  │               370 │
│ PD-P20 'Bastion' PDT  │                 2 │
│  PD-P11 'Pavise' PDT  │                 1 │
│         RestoresTotal │                 7 │
│        DCTeamsCarried │                 6 │
└───────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│   NotEliminated │   13 │  34 │   0.43 │   0.165 │
│ Destroyed/Other │   17 │  15 │   0.19 │   0.215 │
│           Total │   49 │  30 │   0.38 │    0.62 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 69, 72 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Solomon Battleship │    72 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│    PD-Mk29 'Stonewall' PDT  │  3.66667 │  0.0295831 │          12.7232 │
│             WEAP-450mm Gun  │  652.736 │  0.0202285 │          8.69995 │
│            WEAP-Beam Turret │ 0.194444 │  0.0189959 │          8.16983 │
│ DEC-Stock/EA99 Active Decoy │  3.20833 │  0.0164659 │          7.08171 │
│             WEAP-250mm Gun  │  765.611 │  0.0113356 │          4.87527 │
│     PD-Mk20 'Defender' PDT  │  2.41667 │ 0.00885767 │          3.80953 │
│              DCTeamsCarried │  14.5278 │ 0.00859547 │          3.69677 │
│                EWAR-Jammers │    1.125 │ 0.00792176 │          3.40702 │
│               RestoresTotal │     7.25 │ 0.00727202 │          3.12757 │
│           OriginalPointCost │  2543.51 │ 0.00709509 │          3.05148 │
│      PD-Mk25 'Rebound' PDT  │ 0.597222 │ 0.00604867 │          2.60143 │
│        MIS-Stock/SGT-3 Body │  1.04167 │ 0.00577323 │          2.48297 │
│  DEC-Stock/EA20 Flare Decoy │  2.26389 │ 0.00525298 │          2.25922 │
│  DEC-Stock/EA12 Chaff Decoy │  6.52778 │ 0.00508097 │          2.18524 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬──────────────────────────┐
│                    variable │                    value │
├─────────────────────────────┼──────────────────────────┤
│                     hullKey │ Stock/Solomon Battleship │
│           OriginalPointCost │                     2455 │
│             WEAP-450mm Gun  │                      599 │
│             WEAP-250mm Gun  │                      850 │
│            WEAP-Beam Turret │                        1 │
│     PD-Mk20 'Defender' PDT  │                        3 │
│    PD-Mk29 'Stonewall' PDT  │                        4 │
│  DEC-Stock/EA12 Chaff Decoy │                       48 │
│  DEC-Stock/EA20 Flare Decoy │                       16 │
│ DEC-Stock/EA99 Active Decoy │                       10 │
│               RestoresTotal │                        4 │
│              DCTeamsCarried │                        8 │
└─────────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  33 │   10 │  0.458 │   0.139 │
│ Destroyed/Other │   5 │   24 │  0.069 │   0.333 │
│           Total │  38 │   34 │  0.528 │   0.472 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 70, 72 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Feeder │    50 │
│     Stock/Tugboat │    22 │
└───────────────────┴───────┘


### Components

┌──────────────────────────┬───────────┬────────────┬──────────────────┐
│                    Names │   meanVal │ proportion │ scaledProportion │
├──────────────────────────┼───────────┼────────────┼──────────────────┤
│          WEAP-100mm Gun  │   4165.28 │  0.0427309 │          18.3778 │
│            PD-100mm Gun  │   1.11111 │  0.0185057 │          7.95898 │
│       WEAP-400mm Plasma  │   122.917 │  0.0137281 │          5.90423 │
│ MIS-Stock/S3 Sprint Mine │  0.833333 │ 0.00603622 │          2.59608 │
│   WEAP-TE45 Mass Driver  │   33.3333 │ 0.00559964 │          2.40831 │
│    PD-P20 'Bastion' PDT  │  0.861111 │ 0.00525201 │           2.2588 │
│     PD-P11 'Pavise' PDT  │  0.527778 │ 0.00505386 │          2.17358 │
│     WEAP-450mm Casemate  │   70.8333 │ 0.00449221 │          1.93202 │
│      PD-P60 'Grazer' PDT │  0.277778 │ 0.00335514 │          1.44299 │
│            RestoresTotal │   2.59722 │ 0.00260511 │          1.12041 │
│          EWAR-Omnijammer │ 0.0416667 │ 0.00238474 │          1.02564 │
│           DCTeamsCarried │   2.77778 │ 0.00164349 │         0.706839 │
│     WEAP-250mm Casemate  │   44.4167 │ 0.00160379 │         0.689764 │
│        OriginalPointCost │   519.736 │ 0.00144979 │         0.623533 │
└──────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────┬───────────────────┐
│           variable │             value │
├────────────────────┼───────────────────┤
│            hullKey │ Stock/Bulk Feeder │
│  OriginalPointCost │               531 │
│    WEAP-100mm Gun  │              4000 │
│ WEAP-400mm Plasma  │               110 │
│      RestoresTotal │                 2 │
│     DCTeamsCarried │                 3 │
└────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   42 │  16 │  0.222 │   0.583 │
│   NotEliminated │    2 │  12 │  0.167 │   0.028 │
│           Total │   28 │  44 │  0.611 │   0.389 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 71, 71 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│ Stock/Axford Heavy Cruiser │    38 │
│       Stock/Ocello Cruiser │    33 │
└────────────────────────────┴───────┘


### Components

┌────────────────────────────┬──────────┬────────────┬──────────────────┐
│                      Names │  meanVal │ proportion │ scaledProportion │
├────────────────────────────┼──────────┼────────────┼──────────────────┤
│            WEAP-250mm Gun  │  2757.94 │   0.040267 │          17.5621 │
│           WEAP-Beam Turret │ 0.169014 │  0.0162822 │          7.10134 │
│   PD-Mk29 'Stonewall' PDT  │  1.50704 │  0.0119901 │          5.22939 │
│       PD-Mk90 'Aurora' PDT │ 0.507042 │ 0.00885827 │          3.86345 │
│            EWAR-Omnijammer │ 0.140845 │ 0.00794913 │          3.46694 │
│     PD-Mk25 'Rebound' PDT  │ 0.774648 │ 0.00773667 │          3.37428 │
│    PD-Mk20 'Defender' PDT  │  1.67606 │ 0.00605783 │          2.64207 │
│       PD-P11 'Pavise' PDT  │ 0.619718 │ 0.00585184 │          2.55223 │
│ DEC-Stock/EA12 Chaff Decoy │  7.01408 │ 0.00538367 │          2.34804 │
│             DCTeamsCarried │   9.1831 │ 0.00535779 │          2.33675 │
│              RestoresTotal │  5.25352 │ 0.00519629 │          2.26631 │
│     PD-Mk95 'Sarissa' PDT  │ 0.338028 │ 0.00499272 │          2.17753 │
│          OriginalPointCost │  1562.04 │ 0.00429677 │            1.874 │
│ DEC-Stock/EA20 Flare Decoy │  1.42254 │ 0.00325491 │           1.4196 │
└────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬────────────────────────────┐
│                 variable │                      value │
├──────────────────────────┼────────────────────────────┤
│                  hullKey │ Stock/Axford Heavy Cruiser │
│        OriginalPointCost │                       1579 │
│          WEAP-250mm Gun  │                       2700 │
│  PD-Mk20 'Defender' PDT  │                          3 │
│ PD-Mk29 'Stonewall' PDT  │                          4 │
│            RestoresTotal │                          5 │
│           DCTeamsCarried │                         10 │
└──────────────────────────┴────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   36 │   9 │  0.127 │   0.507 │
│   NotEliminated │   10 │  16 │  0.225 │   0.141 │
│           Total │   25 │  46 │  0.648 │   0.352 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 72, 70 hulls

### Hull Counts

┌────────────────────────┬───────┐
│                  Hulls │ Count │
├────────────────────────┼───────┤
│      Stock/Bulk Hauler │    49 │
│ Stock/Container Hauler │    17 │
│   Stock/Raines Frigate │     4 │
└────────────────────────┴───────┘


### Components

┌───────────────────────────────────────┬──────────┬────────────┬──────────────────┐
│                                 Names │  meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼──────────┼────────────┼──────────────────┤
│                  MIS-Stock/SGM-2 Body │  129.686 │  0.0541495 │          23.9542 │
│ MIS-Stock/Decoy Container (Line Ship) │  1.35714 │  0.0399495 │          17.6725 │
│            MIS-Stock/Rocket Container │  3.65714 │  0.0361378 │          15.9863 │
│                   MIS-Stock/CM-4 Body │  30.6571 │  0.0309941 │          13.7109 │
│              MIS-Stock/Mine Container │  2.71429 │  0.0293663 │          12.9908 │
│                 MIS-Stock/S3 Net Mine │  1.48571 │  0.0284075 │          12.5667 │
│                     EWAR-Illuminators │ 0.542857 │  0.0209482 │          9.26688 │
│                  PD-P11 'Pavise' PDT  │  1.78571 │  0.0166246 │          7.35423 │
│   MIS-Stock/Decoy Container (Clipper) │      0.5 │  0.0157942 │          6.98691 │
│                  MIS-Stock/SGT-3 Body │  2.58571 │  0.0139327 │          6.16344 │
│                     MIS-Stock/S3 Mine │ 0.842857 │  0.0136669 │          6.04585 │
│                            PD-Jammers │ 0.157143 │   0.011828 │          5.23235 │
│                   MIS-Stock/S1 Rocket │  10.5429 │ 0.00823146 │          3.64136 │
│                 PD-P20 'Bastion' PDT  │      1.3 │  0.0077086 │          3.41006 │
│                   PD-P60 'Grazer' PDT │ 0.571429 │ 0.00671028 │          2.96844 │
└───────────────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────────┐
│              variable │             value │
├───────────────────────┼───────────────────┤
│               hullKey │ Stock/Bulk Hauler │
│     OriginalPointCost │              2450 │
│  MIS-Stock/SGM-2 Body │               120 │
│ PD-P20 'Bastion' PDT  │                 4 │
│   PD-P60 'Grazer' PDT │                 3 │
│         RestoresTotal │                 3 │
│        DCTeamsCarried │                 5 │
└───────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│ Destroyed/Other │  15 │   28 │  0.214 │     0.4 │
│   NotEliminated │  16 │   11 │  0.229 │   0.157 │
│           Total │  31 │   39 │  0.443 │   0.557 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 73, 67 hulls

### Hull Counts

┌────────────────────────┬───────┐
│                  Hulls │ Count │
├────────────────────────┼───────┤
│      Stock/Bulk Hauler │    66 │
│ Stock/Container Hauler │     1 │
└────────────────────────┴───────┘


### Components

┌───────────────────────────────────────┬──────────┬────────────┬──────────────────┐
│                                 Names │  meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼──────────┼────────────┼──────────────────┤
│                         PD-100mm Gun  │  5.61194 │  0.0869766 │          40.1988 │
│                       WEAP-100mm Gun  │  5115.69 │  0.0488364 │          22.5712 │
│                    WEAP-400mm Plasma  │  249.254 │   0.025905 │          11.9728 │
│ MIS-Stock/Decoy Container (Line Ship) │ 0.686567 │   0.019344 │          8.94039 │
│              MIS-Stock/Mine Container │  1.67164 │  0.0173107 │          8.00063 │
│                 PD-P20 'Bastion' PDT  │  1.29851 │ 0.00736976 │          3.40615 │
│                  WEAP-250mm Casemate  │  185.821 │ 0.00624365 │          2.88568 │
│            DEC-Stock/EA20 Flare Decoy │  2.76119 │ 0.00596197 │           2.7555 │
│            DEC-Stock/EA12 Chaff Decoy │  8.19403 │ 0.00593501 │          2.74304 │
│                         RestoresTotal │  5.95522 │  0.0055585 │          2.56902 │
│                   PD-P60 'Grazer' PDT │ 0.402985 │ 0.00452944 │          2.09341 │
│                  PD-P11 'Pavise' PDT  │ 0.477612 │ 0.00425589 │          1.96698 │
│                        DCTeamsCarried │  6.80597 │ 0.00374716 │          1.73186 │
│   MIS-Stock/Decoy Container (Clipper) │ 0.119403 │ 0.00361011 │          1.66852 │
│                     OriginalPointCost │  1172.12 │ 0.00304255 │           1.4062 │
└───────────────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────────┐
│              variable │             value │
├───────────────────────┼───────────────────┤
│               hullKey │ Stock/Bulk Hauler │
│     OriginalPointCost │              1240 │
│       WEAP-100mm Gun  │              5000 │
│    WEAP-400mm Plasma  │               150 │
│ PD-P20 'Bastion' PDT  │                 4 │
│   PD-P60 'Grazer' PDT │                 3 │
│         PD-100mm Gun  │                 6 │
│         RestoresTotal │                 8 │
│        DCTeamsCarried │                 7 │
└───────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   34 │  13 │  0.194 │   0.507 │
│   NotEliminated │    3 │  17 │  0.254 │   0.045 │
│           Total │   30 │  37 │  0.552 │   0.448 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 74, 65 hulls

### Hull Counts

┌──────────────────────────┬───────┐
│                    Hulls │ Count │
├──────────────────────────┼───────┤
│ Stock/Keystone Destroyer │    65 │
└──────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬─────────────┬──────────────────┐
│                       Names │   meanVal │  proportion │ scaledProportion │
├─────────────────────────────┼───────────┼─────────────┼──────────────────┤
│      WEAP-Mk600 Beam Cannon │  0.953846 │   0.0435699 │          20.7567 │
│             WEAP-120mm Gun  │   2684.74 │    0.043385 │          20.6686 │
│      PD-Mk25 'Rebound' PDT  │       2.6 │   0.0237727 │          11.3253 │
│               PD-120mm Gun  │   1.92308 │   0.0192634 │          9.17707 │
│    PD-Mk29 'Stonewall' PDT  │       0.4 │  0.00291349 │          1.38799 │
│     PD-Mk20 'Defender' PDT  │  0.584615 │  0.00193443 │         0.921564 │
│  DEC-Stock/EA20 Flare Decoy │  0.876923 │  0.00183693 │         0.875114 │
│           OriginalPointCost │   697.954 │  0.00175765 │         0.837342 │
│              DCTeamsCarried │   3.01538 │  0.00161062 │         0.767301 │
│               RestoresTotal │   1.64615 │  0.00149062 │         0.710133 │
│         WEAP-Mk550 Railgun  │   1.53846 │ 0.000573079 │         0.273015 │
│ DEC-Stock/EA99 Active Decoy │  0.107692 │ 0.000498966 │         0.237708 │
│  DEC-Stock/EA12 Chaff Decoy │  0.692308 │ 0.000486476 │         0.231757 │
│                EWAR-Jammers │ 0.0461538 │ 0.000293399 │         0.139775 │
└─────────────────────────────┴───────────┴─────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────────┐
│                 variable │                    value │
├──────────────────────────┼──────────────────────────┤
│                  hullKey │ Stock/Keystone Destroyer │
│        OriginalPointCost │                      755 │
│          WEAP-120mm Gun  │                     2200 │
│   WEAP-Mk600 Beam Cannon │                        1 │
│            PD-120mm Gun  │                        2 │
│  PD-Mk20 'Defender' PDT  │                        2 │
│ PD-Mk29 'Stonewall' PDT  │                        2 │
│            RestoresTotal │                        3 │
│           DCTeamsCarried │                        5 │
└──────────────────────────┴──────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  15 │    3 │  0.231 │   0.046 │
│ Destroyed/Other │  15 │   32 │  0.231 │   0.492 │
│           Total │  30 │   35 │  0.462 │   0.538 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 75, 64 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │    64 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬──────────┬────────────┬──────────────────┐
│                                 Names │  meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼──────────┼────────────┼──────────────────┤
│                  WEAP-250mm Casemate  │  2524.38 │   0.081022 │           39.202 │
│                 PD-P20 'Bastion' PDT  │   1.6875 │ 0.00914867 │          4.42652 │
│ MIS-Stock/Decoy Container (Line Ship) │   0.3125 │ 0.00841043 │          4.06933 │
│            MIS-Stock/Rocket Container │     0.75 │ 0.00677583 │          3.27844 │
│                         RestoresTotal │  6.57812 │ 0.00586498 │          2.83773 │
│                  PD-P11 'Pavise' PDT  │ 0.578125 │ 0.00492087 │          2.38093 │
│              MIS-Stock/Mine Container │    0.375 │ 0.00370943 │          1.79478 │
│                   PD-P60 'Grazer' PDT │  0.34375 │ 0.00369066 │           1.7857 │
│                        DCTeamsCarried │   6.4375 │  0.0033856 │           1.6381 │
│                     EWAR-Illuminators │ 0.078125 │ 0.00275634 │          1.33364 │
│                     OriginalPointCost │  1034.22 │ 0.00256439 │          1.24076 │
│                  MIS-Stock/SGM-2 Body │    6.375 │ 0.00243369 │          1.17752 │
│            DEC-Stock/EA20 Flare Decoy │  1.17188 │ 0.00241702 │          1.16946 │
│            DEC-Stock/EA12 Chaff Decoy │  3.29688 │ 0.00228103 │          1.10366 │
└───────────────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌────────────────────────────┬───────────────────┐
│                   variable │             value │
├────────────────────────────┼───────────────────┤
│                    hullKey │ Stock/Bulk Hauler │
│          OriginalPointCost │               993 │
│       WEAP-250mm Casemate  │              2500 │
│      PD-P20 'Bastion' PDT  │                 2 │
│        PD-P60 'Grazer' PDT │                 1 │
│ DEC-Stock/EA12 Chaff Decoy │                13 │
│              RestoresTotal │                 9 │
│             DCTeamsCarried │                 8 │
└────────────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   15 │   6 │  0.094 │   0.234 │
│   NotEliminated │    9 │  34 │  0.531 │   0.141 │
│           Total │   40 │  24 │  0.375 │   0.625 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 76, 62 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │    62 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬───────────┬────────────┬──────────────────┐
│                                 Names │   meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼───────────┼────────────┼──────────────────┤
│                         PD-100mm Gun  │   3.27419 │  0.0469581 │          23.4533 │
│                    WEAP-400mm Plasma  │   451.935 │  0.0434646 │          21.7084 │
│                       WEAP-100mm Gun  │   3430.81 │  0.0303077 │          15.1372 │
│ MIS-Stock/Decoy Container (Line Ship) │  0.548387 │  0.0142977 │          7.14102 │
│                  PD-P11 'Pavise' PDT  │   1.03226 │ 0.00851177 │          4.25122 │
│                 PD-P20 'Bastion' PDT  │   1.27419 │ 0.00669208 │          3.34237 │
│            DEC-Stock/EA20 Flare Decoy │   3.33871 │ 0.00667096 │          3.33182 │
│                         RestoresTotal │   6.48387 │ 0.00560029 │          2.79707 │
│                WEAP-TE45 Mass Driver  │   31.9355 │  0.0046197 │          2.30732 │
│                        DCTeamsCarried │   7.14516 │ 0.00364034 │          1.81817 │
│            DEC-Stock/EA12 Chaff Decoy │   4.51613 │ 0.00302696 │          1.51182 │
│                     OriginalPointCost │   1183.15 │ 0.00284198 │          1.41943 │
│                     EWAR-Illuminators │ 0.0806452 │ 0.00275634 │          1.37666 │
│                 MIS-Stock/S3 Net Mine │   0.16129 │ 0.00273149 │          1.36425 │
│                   PD-P60 'Grazer' PDT │  0.258065 │ 0.00268411 │          1.34058 │
└───────────────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────┬───────────────────┐
│              variable │             value │
├───────────────────────┼───────────────────┤
│               hullKey │ Stock/Bulk Hauler │
│     OriginalPointCost │              1238 │
│       WEAP-100mm Gun  │              3200 │
│    WEAP-400mm Plasma  │               280 │
│ PD-P20 'Bastion' PDT  │                 4 │
│   PD-P60 'Grazer' PDT │                 1 │
│         RestoresTotal │                10 │
│        DCTeamsCarried │                10 │
└───────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  19 │    6 │  0.306 │   0.097 │
│ Destroyed/Other │  13 │   24 │   0.21 │   0.387 │
│           Total │  32 │   30 │  0.516 │   0.484 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 77, 59 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │    59 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬───────────┬────────────┬──────────────────┐
│                       Names │   meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼───────────┼────────────┼──────────────────┤
│      MIS-Stock/SGM-H-3 Body │   18.8305 │  0.0437436 │          22.9587 │
│      MIS-Stock/SGM-H-2 Body │   17.4576 │  0.0239179 │          12.5532 │
│        MIS-Stock/SGT-3 Body │   4.47458 │  0.0203218 │          10.6658 │
│ DEC-Stock/EA99 Active Decoy │   2.01695 │ 0.00848243 │          4.45198 │
│        MIS-Stock/SGM-1 Body │   7.28814 │ 0.00786135 │          4.12601 │
│     PD-Mk20 'Defender' PDT  │   2.28814 │ 0.00687233 │          3.60692 │
│        MIS-Stock/SGM-2 Body │   18.3898 │ 0.00647193 │          3.39678 │
│  DEC-Stock/EA20 Flare Decoy │   2.86441 │ 0.00544634 │           2.8585 │
│           OriginalPointCost │   2326.36 │ 0.00531765 │          2.79095 │
│  DEC-Stock/EA12 Chaff Decoy │    7.0339 │ 0.00448639 │          2.35467 │
│              DCTeamsCarried │   6.13559 │ 0.00297472 │          1.56128 │
│               RestoresTotal │   3.37288 │ 0.00277228 │          1.45503 │
│           EWAR-Illuminators │ 0.0847458 │ 0.00275634 │          1.44666 │
│        PD-Mk90 'Aurora' PDT │  0.186441 │ 0.00270669 │           1.4206 │
└─────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────┬──────────────────────────────┐
│                variable │                        value │
├─────────────────────────┼──────────────────────────────┤
│                 hullKey │ Stock/Vauxhall Light Cruiser │
│       OriginalPointCost │                         2340 │
│  MIS-Stock/SGM-H-3 Body │                           30 │
│ PD-Mk20 'Defender' PDT  │                            4 │
│           RestoresTotal │                            2 │
│          DCTeamsCarried │                            5 │
└─────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   27 │  11 │  0.186 │   0.458 │
│   NotEliminated │    5 │  16 │  0.271 │   0.085 │
│           Total │   27 │  32 │  0.542 │   0.458 │
└─────────────────┴──────┴─────┴────────┴─────────┘


## Cluster 78, 58 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Hauler │    58 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬───────────┬────────────┬──────────────────┐
│                                 Names │   meanVal │ proportion │ scaledProportion │
├───────────────────────────────────────┼───────────┼────────────┼──────────────────┤
│                    WEAP-400mm Plasma  │    485.69 │  0.0436972 │          23.3298 │
│                         PD-100mm Gun  │   2.06897 │  0.0277585 │          14.8202 │
│                       WEAP-100mm Gun  │   2072.52 │  0.0171274 │          9.14426 │
│ MIS-Stock/Decoy Container (Line Ship) │  0.689655 │  0.0168209 │           8.9806 │
│   MIS-Stock/Decoy Container (Clipper) │  0.327586 │ 0.00857401 │          4.57763 │
│                         RestoresTotal │   7.36207 │ 0.00594857 │          3.17592 │
│                 PD-P20 'Bastion' PDT  │   1.13793 │ 0.00559085 │          2.98494 │
│            DEC-Stock/EA20 Flare Decoy │   2.74138 │ 0.00512407 │          2.73573 │
│                WEAP-TE45 Mass Driver  │   27.5862 │ 0.00373309 │          1.99309 │
│              MIS-Stock/Mine Container │  0.413793 │ 0.00370943 │          1.98045 │
│            DEC-Stock/EA12 Chaff Decoy │   5.36207 │ 0.00336209 │          1.79501 │
│                  PD-P11 'Pavise' PDT  │  0.431034 │ 0.00332491 │          1.77516 │
│                       EWAR-Omnijammer │ 0.0689655 │ 0.00317965 │           1.6976 │
│                        DCTeamsCarried │   5.96552 │ 0.00284324 │            1.518 │
│                     OriginalPointCost │   1102.12 │ 0.00247656 │          1.32223 │
└───────────────────────────────────────┴───────────┴────────────┴──────────────────┘


### Exemplar

┌───────────────────────────────────────┬───────────────────┐
│                              variable │             value │
├───────────────────────────────────────┼───────────────────┤
│                               hullKey │ Stock/Bulk Hauler │
│                     OriginalPointCost │              1131 │
│                       WEAP-100mm Gun  │              2100 │
│                    WEAP-400mm Plasma  │               500 │
│ MIS-Stock/Decoy Container (Line Ship) │                 2 │
│   MIS-Stock/Decoy Container (Clipper) │                 2 │
│                       EWAR-Omnijammer │                 1 │
│                         PD-100mm Gun  │                 5 │
│                         RestoresTotal │                 7 │
│                        DCTeamsCarried │                 6 │
└───────────────────────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  29 │    5 │    0.5 │   0.086 │
│ Destroyed/Other │   3 │   21 │  0.052 │   0.362 │
│           Total │  32 │   26 │  0.552 │   0.448 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 79, 55 hulls

### Hull Counts

┌───────────────────┬───────┐
│             Hulls │ Count │
├───────────────────┼───────┤
│ Stock/Bulk Feeder │    55 │
└───────────────────┴───────┘


### Components

┌───────────────────────────────────────┬───────────┬─────────────┬──────────────────┐
│                                 Names │   meanVal │  proportion │ scaledProportion │
├───────────────────────────────────────┼───────────┼─────────────┼──────────────────┤
│                WEAP-TE45 Mass Driver  │   977.855 │    0.125483 │          70.6494 │
│                  MIS-Stock/SGT-3 Body │   2.83636 │   0.0120083 │           6.7609 │
│                   PD-P60 'Grazer' PDT │  0.727273 │  0.00671028 │          3.77801 │
│                       EWAR-Omnijammer │  0.109091 │  0.00476948 │           2.6853 │
│            MIS-Stock/Rocket Container │  0.290909 │  0.00225861 │          1.27164 │
│                  PD-P11 'Pavise' PDT  │  0.290909 │  0.00212794 │          1.19807 │
│                     OriginalPointCost │   583.327 │  0.00124299 │         0.699824 │
│                 PD-P20 'Bastion' PDT  │  0.254545 │  0.00118594 │         0.667705 │
│                        DCTeamsCarried │   2.01818 │ 0.000912139 │         0.513551 │
│                         RestoresTotal │   1.16364 │ 0.000891588 │          0.50198 │
│                          EWAR-Jammers │  0.163636 │ 0.000880196 │         0.495566 │
│ MIS-Stock/Decoy Container (Line Ship) │ 0.0181818 │ 0.000420521 │         0.236761 │
│                    WEAP-400mm Plasma  │   3.72727 │ 0.000317996 │         0.179037 │
│              MIS-Stock/Mine Container │ 0.0363636 │ 0.000309119 │          0.17404 │
└───────────────────────────────────────┴───────────┴─────────────┴──────────────────┘


### Exemplar

┌────────────────────────┬───────────────────┐
│               variable │             value │
├────────────────────────┼───────────────────┤
│                hullKey │ Stock/Bulk Feeder │
│      OriginalPointCost │               595 │
│ WEAP-TE45 Mass Driver  │              1000 │
│  PD-P20 'Bastion' PDT  │                 1 │
│    PD-P60 'Grazer' PDT │                 1 │
└────────────────────────┴───────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  16 │    9 │  0.291 │   0.164 │
│ Destroyed/Other │   3 │   27 │  0.055 │   0.491 │
│           Total │  19 │   36 │  0.345 │   0.655 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 80, 55 hulls

### Hull Counts

┌────────────────────────────┬───────┐
│                      Hulls │ Count │
├────────────────────────────┼───────┤
│ Stock/Axford Heavy Cruiser │    45 │
│       Stock/Ocello Cruiser │    10 │
└────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│            WEAP-Beam Turret │ 0.272727 │  0.0203528 │           11.459 │
│      MIS-Stock/SGM-H-3 Body │  8.23636 │  0.0178361 │           10.042 │
│    PD-Mk29 'Stonewall' PDT  │  2.23636 │  0.0137831 │          7.76011 │
│      MIS-Stock/SGM-H-2 Body │  10.1818 │  0.0130039 │          7.32143 │
│                  PD-Jammers │ 0.218182 │  0.0129032 │          7.26475 │
│    MIS-Stock/S3 Sprint Mine │  2.18182 │  0.0120724 │            6.797 │
│        PD-Mk90 'Aurora' PDT │ 0.781818 │  0.0105807 │          5.95713 │
│             WEAP-250mm Gun  │  919.055 │  0.0103946 │          5.85237 │
│        MIS-Stock/SGT-3 Body │  2.38182 │  0.0100839 │          5.67742 │
│ DEC-Stock/EA99 Active Decoy │  1.92727 │ 0.00755578 │          4.25404 │
│           OriginalPointCost │  2508.36 │ 0.00534496 │          3.00931 │
│             WEAP-450mm Gun  │    214.0 │ 0.00506606 │          2.85228 │
│      PD-Mk95 'Sarissa' PDT  │ 0.436364 │ 0.00499272 │          2.81099 │
│             EWAR-Omnijammer │ 0.109091 │ 0.00476948 │           2.6853 │
│     PD-Mk20 'Defender' PDT  │  1.69091 │ 0.00473427 │          2.66548 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌─────────────────────────────┬────────────────────────────┐
│                    variable │                      value │
├─────────────────────────────┼────────────────────────────┤
│                     hullKey │ Stock/Axford Heavy Cruiser │
│           OriginalPointCost │                       2503 │
│             WEAP-450mm Gun  │                        375 │
│             WEAP-250mm Gun  │                        900 │
│      MIS-Stock/SGM-H-3 Body │                         16 │
│        MIS-Stock/SGM-1 Body │                         10 │
│      PD-Mk95 'Sarissa' PDT  │                          2 │
│     PD-Mk20 'Defender' PDT  │                          3 │
│    PD-Mk29 'Stonewall' PDT  │                          2 │
│  DEC-Stock/EA20 Flare Decoy │                          5 │
│ DEC-Stock/EA99 Active Decoy │                          3 │
│               RestoresTotal │                          5 │
│              DCTeamsCarried │                         11 │
└─────────────────────────────┴────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬─────┬──────┬────────┬─────────┐
│      Eliminated │ Win │ Loss │ WinPct │ LossPct │
├─────────────────┼─────┼──────┼────────┼─────────┤
│   NotEliminated │  24 │    8 │  0.436 │   0.145 │
│ Destroyed/Other │   3 │   20 │  0.055 │   0.364 │
│           Total │  27 │   28 │  0.491 │   0.509 │
└─────────────────┴─────┴──────┴────────┴─────────┘


## Cluster 81, 51 hulls

### Hull Counts

┌──────────────────────────────┬───────┐
│                        Hulls │ Count │
├──────────────────────────────┼───────┤
│ Stock/Vauxhall Light Cruiser │    51 │
└──────────────────────────────┴───────┘


### Components

┌─────────────────────────────┬──────────┬────────────┬──────────────────┐
│                       Names │  meanVal │ proportion │ scaledProportion │
├─────────────────────────────┼──────────┼────────────┼──────────────────┤
│               PD-120mm Gun  │  2.86275 │  0.0224996 │          13.6612 │
│             WEAP-120mm Gun  │  1052.94 │  0.0133505 │          8.10612 │
│      PD-Mk25 'Rebound' PDT  │  1.29412 │ 0.00928401 │          5.63703 │
│     PD-Mk20 'Defender' PDT  │  2.19608 │ 0.00570149 │          3.46181 │
│                EWAR-Jammers │ 0.803922 │ 0.00400978 │          2.43464 │
│ DEC-Stock/EA99 Active Decoy │ 0.843137 │ 0.00306508 │          1.86104 │
│               PD-250mm Gun  │ 0.509804 │ 0.00264067 │          1.60335 │
│  DEC-Stock/EA20 Flare Decoy │  1.54902 │ 0.00254592 │          1.54582 │
│        MIS-Stock/SGM-1 Body │  2.70588 │ 0.00252294 │          1.53187 │
│      PD-Mk95 'Sarissa' PDT  │ 0.235294 │ 0.00249636 │          1.51573 │
│              DCTeamsCarried │  5.47059 │ 0.00229267 │          1.39206 │
│           OriginalPointCost │  988.392 │ 0.00195295 │          1.18578 │
│  DEC-Stock/EA12 Chaff Decoy │   3.4902 │ 0.00192428 │          1.16838 │
│               RestoresTotal │  2.56863 │ 0.00182497 │          1.10808 │
└─────────────────────────────┴──────────┴────────────┴──────────────────┘


### Exemplar

┌──────────────────────────┬──────────────────────────────┐
│                 variable │                        value │
├──────────────────────────┼──────────────────────────────┤
│                  hullKey │ Stock/Vauxhall Light Cruiser │
│        OriginalPointCost │                         1004 │
│          WEAP-120mm Gun  │                         1000 │
│             EWAR-Jammers │                            4 │
│            PD-120mm Gun  │                            2 │
│   PD-Mk95 'Sarissa' PDT  │                            1 │
│   PD-Mk25 'Rebound' PDT  │                            1 │
│  PD-Mk20 'Defender' PDT  │                            1 │
│ PD-Mk29 'Stonewall' PDT  │                            1 │
│            RestoresTotal │                            2 │
│           DCTeamsCarried │                            4 │
└──────────────────────────┴──────────────────────────────┘


### Hull Outcome vs WinRate

┌─────────────────┬──────┬─────┬────────┬─────────┐
│      Eliminated │ Loss │ Win │ WinPct │ LossPct │
├─────────────────┼──────┼─────┼────────┼─────────┤
│ Destroyed/Other │   25 │   8 │  0.157 │    0.49 │
│   NotEliminated │    5 │  13 │  0.255 │   0.098 │
│           Total │   21 │  30 │  0.588 │   0.412 │
└─────────────────┴──────┴─────┴────────┴─────────┘


