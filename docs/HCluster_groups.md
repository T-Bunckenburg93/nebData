# Cluster Hulls by Componenets

I've doing a clustering analysis to build on the point distributon analysis I did initally. 
The most common response, and my thoughts while I was building it, was that point cost is not a simple indication of ship build, and thus outcome. So I've spent a bit of time refining it, primarily by adding a bunch of components into the mix. 

Ive tried to build a model that both accomodates common builds, but also includes more niche builds that do show up. 
This has led to some overlap, and prossibly some differential of clusters that doesn't really exist, as well as lots of clusters ( 29 ), but I do feel/hope that this is reasonable representative of the ships rolls that you can see in Nebulous.

## Description of the tables:

### Hull Counts
Hull count shuld be pretty obvious. Generally there is one, but often there is overlap 

### Components
Here I tried to identify the specific componenets that made up a cluster. 
* meanVal, is the average number of that value that you would expect to see on this rype of hull. 
* proportion, is the proportion of this component that is in this cluster. for example, the first group contains about 50% of all S1/rockets
* scaledProportion, is this, but scaled by the size of the cluster, to make this number more meaningful for smaller clusters. if you had a component 50% of the time, and the size of the cluster was 10% of all ships, this number would be 5

Note that for weapons and missiles, the values are the ammo count, not the number of weapons. 

### Exemplar
Each cluster is focused around a single ship that serves at the exemplar. This is the hull/components that this exemplar had.

### Hull Outcome vs WinRate
Counts and Percentages of wins and losses vs the ship being eliminated or not. Ideally this should show if the cluster is effective or not.



Now I'm not going to do a writeup of each one, as there are 29, but I do hope this is interesting. I will be using these clusters in the future to try and group fleet types, as I feel there is a lot of interesting things to unpack there.

Enjoy, and let me know what you think!

# Clusters:

## Cluster 1, 10072 hulls

### Hull Counts

|                   Hulls | Count |
|-------------------------|-------|
|           Stock/Tugboat |  3044 |
|           Stock/Shuttle |  2906 |
| Stock/Sprinter Corvette |  2191 |
|       Stock/Bulk Feeder |  1931 |


### Components

|                    Names |   meanVal | proportion | scaledProportion |
|--------------------------|-----------|------------|------------------|
|      MIS-Stock/S1 Rocket |   7.44053 |   0.835873 |          2.56986 |
|    MIS-Stock/S3 Net Mine |  0.237292 |   0.652827 |          2.00709 |
|        MIS-Stock/S3 Mine |  0.274921 |   0.641418 |          1.97202 |
|     MIS-Stock/SGM-1 Body |   2.50685 |   0.461607 |           1.4192 |
| MIS-Stock/S3 Sprint Mine |  0.396148 |   0.401408 |          1.23412 |
|               PD-Jammers | 0.0357427 |   0.387097 |          1.19012 |
|      PD-P60 'Grazer' PDT |  0.218527 |   0.369233 |          1.13519 |
|     MIS-Stock/SGT-3 Body |  0.473292 |   0.366946 |          1.12816 |


### Hull Outcome vs WinRate

|      Eliminated |  Win | Loss | WinPct | LossPct |
|-----------------|------|------|--------|---------|
|   NotEliminated | 3504 |  921 |  0.348 |   0.092 |
| Destroyed/Other | 2133 | 3506 |  0.212 |   0.348 |
|           Total | 5637 | 4427 |   0.56 |    0.44 |


## Cluster 2, 2609 hulls

### Hull Counts

|                      Hulls | Count |
|----------------------------|-------|
|       Stock/Ocello Cruiser |  1783 |
| Stock/Axford Heavy Cruiser |   826 |


### Components

|                    Names |  meanVal | proportion | scaledProportion |
|--------------------------|----------|------------|------------------|
|      WEAP-300mm Railgun  |  33.8835 |   0.671182 |           7.9662 |
|     PD-Mk90 'Aurora' PDT | 0.863166 |   0.554134 |          6.57697 |
|          EWAR-Omnijammer | 0.247988 |   0.514308 |          6.10428 |
|   PD-Mk95 'Sarissa' PDT  |  0.93944 |   0.509881 |          6.05174 |
|          WEAP-450mm Gun  |  543.197 |   0.409761 |          4.86342 |
|               PD-Jammers | 0.123802 |   0.347312 |          4.12221 |
| PD-Mk29 'Stonewall' PDT  | 0.840169 |    0.24563 |          2.91536 |
|        EWAR-Illuminators | 0.135301 |   0.194598 |          2.30966 |


### Hull Outcome vs WinRate

|      Eliminated |  Win | Loss | WinPct | LossPct |
|-----------------|------|------|--------|---------|
|   NotEliminated | 1046 |  426 |  0.402 |   0.164 |
| Destroyed/Other |  255 |  875 |  0.098 |   0.336 |
|           Total | 1301 | 1301 |    0.5 |     0.5 |


## Cluster 3, 2301 hulls

### Hull Counts

|                    Hulls | Count |
|--------------------------|-------|
| Stock/Keystone Destroyer |  2301 |


### Components

|                    Names |  meanVal | proportion | scaledProportion |
|--------------------------|----------|------------|------------------|
|   WEAP-Mk600 Beam Cannon | 0.584963 |   0.945889 |          12.7294 |
|      WEAP-Mk550 Railgun  |  71.4711 |   0.942457 |          12.6832 |
| PD-Mk29 'Stonewall' PDT  | 0.697088 |    0.17974 |          2.41887 |
|  PD-Mk20 'Defender' PDT  |  1.24424 |   0.145744 |          1.96137 |
|   PD-Mk25 'Rebound' PDT  | 0.431551 |   0.139682 |          1.87979 |
|   MIS-Stock/SGM-H-3 Body |  1.51021 |   0.136822 |           1.8413 |
|   MIS-Stock/SGM-H-2 Body |  2.38592 |   0.127485 |          1.71564 |
|            PD-120mm Gun  |  0.34246 |   0.121436 |          1.63424 |


### Hull Outcome vs WinRate

|      Eliminated | Loss |  Win | WinPct | LossPct |
|-----------------|------|------|--------|---------|
| Destroyed/Other |  903 |  314 |  0.136 |   0.392 |
|   NotEliminated |  280 |  804 |  0.349 |   0.122 |
|           Total | 1118 | 1183 |  0.514 |   0.486 |


## Cluster 4, 2296 hulls

### Hull Counts

|                Hulls | Count |
|----------------------|-------|
| Stock/Raines Frigate |  2276 |
|    Stock/Bulk Hauler |    20 |


### Components

|                  Names |  meanVal | proportion | scaledProportion |
|------------------------|----------|------------|------------------|
|           EWAR-Jammers | 0.939895 |   0.211051 |          2.84644 |
|          PD-120mm Gun  | 0.483014 |   0.170905 |          2.30498 |
| PD-Mk95 'Sarissa' PDT  | 0.353659 |    0.16892 |          2.27822 |
|      EWAR-Illuminators | 0.115418 |   0.146086 |          1.97025 |
|        WEAP-120mm Gun  |  209.253 |   0.119445 |          1.61095 |
|          PD-250mm Gun  | 0.343641 |  0.0801341 |          1.08076 |
|   MIS-Stock/SGM-1 Body |  1.86585 |   0.078321 |          1.05631 |


### Hull Outcome vs WinRate

|      Eliminated |  Win | Loss | WinPct | LossPct |
|-----------------|------|------|--------|---------|
|   NotEliminated |  816 |  237 |  0.355 |   0.103 |
| Destroyed/Other |  365 |  878 |  0.159 |   0.382 |
|           Total | 1181 | 1115 |  0.514 |   0.486 |


## Cluster 5, 2108 hulls

### Hull Counts

|             Hulls | Count |
|-------------------|-------|
|     Stock/Shuttle |  1092 |
| Stock/Bulk Feeder |   529 |
|     Stock/Tugboat |   487 |


### Components

|                    Names |  meanVal | proportion | scaledProportion |
|--------------------------|----------|------------|------------------|
|            PD-100mm Gun  |  0.60389 |   0.294471 |          4.32571 |
|          WEAP-100mm Gun  |  616.231 |   0.185088 |           2.7189 |
|        MIS-Stock/S3 Mine | 0.361954 |   0.176743 |          2.59631 |
|    MIS-Stock/S3 Net Mine | 0.222486 |   0.128107 |          1.88186 |
| MIS-Stock/S3 Sprint Mine | 0.451139 |   0.095674 |          1.40543 |
|      PD-P60 'Grazer' PDT | 0.232922 |  0.0823687 |          1.20998 |
|      MIS-Stock/S1 Rocket |  3.15228 |  0.0741166 |          1.08875 |
|     PD-P11 'Pavise' PDT  |  0.26186 |   0.073414 |          1.07843 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
| Destroyed/Other |  791 | 532 |  0.252 |   0.375 |
|   NotEliminated |  121 | 664 |  0.315 |   0.057 |
|           Total | 1196 | 912 |  0.433 |   0.567 |


## Cluster 6, 1567 hulls

### Hull Counts

|                   Hulls | Count |
|-------------------------|-------|
| Stock/Sprinter Corvette |  1567 |


### Components

|                      Names |  meanVal | proportion | scaledProportion |
|----------------------------|----------|------------|------------------|
|              PD-120mm Gun  |  1.23165 |   0.297426 |          5.87754 |
|            WEAP-120mm Gun  |  668.194 |   0.260313 |          5.14412 |
|    PD-Mk20 'Defender' PDT  |  1.13019 |  0.0901548 |          1.78158 |
|     PD-Mk25 'Rebound' PDT  | 0.383535 |  0.0845407 |          1.67064 |
|       MIS-Stock/SGM-1 Body |  1.44288 |  0.0413361 |         0.816855 |
|       MIS-Stock/SGT-3 Body |  0.32993 |  0.0397968 |         0.786437 |
|     MIS-Stock/SGM-H-3 Body | 0.532865 |  0.0328766 |         0.649685 |
| DEC-Stock/EA12 Chaff Decoy |  1.70134 |   0.028821 |         0.569541 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
| Destroyed/Other | 380 |  614 |  0.243 |   0.392 |
|   NotEliminated | 511 |   62 |  0.326 |    0.04 |
|           Total | 891 |  676 |  0.569 |   0.431 |


## Cluster 7, 1370 hulls

### Hull Counts

|                  Hulls | Count |
|------------------------|-------|
|      Stock/Bulk Hauler |   711 |
|   Stock/Raines Frigate |   653 |
| Stock/Container Hauler |     6 |


### Components

|                  Names |  meanVal | proportion | scaledProportion |
|------------------------|----------|------------|------------------|
| WEAP-TE45 Mass Driver  |  160.928 |   0.514402 |           11.627 |
| MIS-Stock/SGM-H-2 Body |  6.29343 |   0.200214 |          4.52541 |
| MIS-Stock/SGM-H-3 Body |  3.41314 |   0.184109 |           4.1614 |
|     WEAP-400mm Plasma  |  56.7715 |   0.120648 |          2.72699 |
|   MIS-Stock/SGM-1 Body |  4.78175 |   0.119767 |          2.70708 |
|   MIS-Stock/SGT-3 Body |  1.12409 |   0.118544 |          2.67943 |
|   PD-P11 'Pavise' PDT  | 0.625547 |   0.113978 |          2.57623 |
|  PD-P20 'Bastion' PDT  | 0.818248 |  0.0949598 |          2.14637 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
|   NotEliminated | 549 |  201 |  0.401 |   0.147 |
| Destroyed/Other | 143 |  475 |  0.105 |   0.347 |
|           Total | 692 |  676 |  0.506 |   0.494 |


## Cluster 8, 1107 hulls

### Hull Counts

|             Hulls | Count |
|-------------------|-------|
| Stock/Bulk Hauler |  1107 |


### Components

|                                 Names |  meanVal | proportion | scaledProportion |
|---------------------------------------|----------|------------|------------------|
|                       WEAP-450mm Gun  |  837.256 |   0.267982 |          7.49622 |
|                 PD-P20 'Bastion' PDT  |  2.42096 |   0.227022 |          6.35048 |
|                  PD-P11 'Pavise' PDT  |  1.24842 |   0.183801 |          5.14145 |
|                   PD-P60 'Grazer' PDT | 0.872629 |   0.162053 |           4.5331 |
| MIS-Stock/Decoy Container (Line Ship) | 0.347787 |   0.161901 |          4.52883 |
|              MIS-Stock/Mine Container |   0.6215 |   0.106337 |          2.97455 |
|                         RestoresTotal |  5.90334 |  0.0910395 |          2.54664 |
|   MIS-Stock/Decoy Container (Clipper) | 0.159892 |  0.0798736 |           2.2343 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
|   NotEliminated | 432 |  176 |  0.392 |    0.16 |
| Destroyed/Other | 144 |  351 |  0.131 |   0.318 |
|           Total | 576 |  527 |  0.522 |   0.478 |


## Cluster 9, 1078 hulls

### Hull Counts

|                        Hulls | Count |
|------------------------------|-------|
| Stock/Vauxhall Light Cruiser |  1078 |


### Components

|                       Names |  meanVal | proportion | scaledProportion |
|-----------------------------|----------|------------|------------------|
|               PD-250mm Gun  |  3.74212 |    0.40971 |          11.7691 |
|             WEAP-250mm Gun  |  1037.89 |    0.16317 |          4.68713 |
|      PD-Mk25 'Rebound' PDT  | 0.940631 |   0.142636 |          4.09728 |
|     PD-Mk20 'Defender' PDT  |  2.43785 |   0.133781 |          3.84292 |
| DEC-Stock/EA99 Active Decoy |  1.49258 |   0.114691 |          3.29455 |
|      MIS-Stock/SGM-H-3 Body |  2.21707 |  0.0941019 |          2.70312 |
|      MIS-Stock/SGM-H-2 Body |   2.4397 |  0.0610719 |          1.75432 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
| Destroyed/Other | 148 |  407 |  0.138 |    0.38 |
|   NotEliminated | 370 |  147 |  0.345 |   0.137 |
|           Total | 518 |  554 |  0.483 |   0.517 |


## Cluster 10, 844 hulls

### Hull Counts

|             Hulls | Count |
|-------------------|-------|
| Stock/Bulk Feeder |   633 |
|     Stock/Tugboat |   118 |
|     Stock/Shuttle |    93 |


### Components

|                 Names |  meanVal | proportion | scaledProportion |
|-----------------------|----------|------------|------------------|
|       WEAP-100mm Gun  |  1885.58 |   0.226752 |          8.31945 |
|         PD-100mm Gun  | 0.759479 |   0.148277 |          5.44021 |
|    WEAP-400mm Plasma  |  112.799 |   0.147677 |          5.41821 |
|   PD-P60 'Grazer' PDT | 0.495261 |  0.0701225 |          2.57276 |
| PD-P20 'Bastion' PDT  | 0.671801 |  0.0480305 |          1.76222 |
| MIS-Stock/S3 Net Mine | 0.165877 |  0.0382409 |          1.40304 |
|  PD-P11 'Pavise' PDT  | 0.329384 |   0.036973 |          1.35652 |
|         RestoresTotal |  2.96801 |  0.0348973 |          1.28037 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
| Destroyed/Other | 144 |  272 |  0.171 |   0.324 |
|   NotEliminated | 339 |   85 |  0.404 |   0.101 |
|           Total | 483 |  357 |  0.575 |   0.425 |


## Cluster 11, 838 hulls

### Hull Counts

|                    Hulls | Count |
|--------------------------|-------|
| Stock/Solomon Battleship |   838 |


### Components

|                       Names |  meanVal | proportion | scaledProportion |
|-----------------------------|----------|------------|------------------|
|            WEAP-Beam Turret | 0.442721 |   0.503392 |          18.6015 |
|    PD-Mk29 'Stonewall' PDT  |  2.72673 |   0.256051 |          9.46167 |
|         WEAP-300mm Railgun  |  36.8652 |   0.234551 |          8.66721 |
|             WEAP-450mm Gun  |  680.425 |   0.164863 |          6.09207 |
| DEC-Stock/EA99 Active Decoy |   2.6253 |   0.156818 |          5.79478 |
|     PD-Mk20 'Defender' PDT  |  3.00239 |    0.12808 |          4.73284 |
|      PD-Mk25 'Rebound' PDT  | 0.868735 |   0.102405 |          3.78411 |
|        PD-Mk90 'Aurora' PDT | 0.453461 |  0.0935039 |          3.45518 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
|   NotEliminated | 335 |  166 |    0.4 |   0.198 |
| Destroyed/Other |  53 |  284 |  0.063 |   0.339 |
|           Total | 388 |  450 |  0.463 |   0.537 |


## Cluster 12, 722 hulls

### Hull Counts

|                        Hulls | Count |
|------------------------------|-------|
| Stock/Vauxhall Light Cruiser |   722 |


### Components

|                       Names | meanVal | proportion | scaledProportion |
|-----------------------------|---------|------------|------------------|
|               PD-250mm Gun  | 4.58033 |   0.335872 |          14.4053 |
|             WEAP-250mm Gun  | 2083.48 |    0.21938 |          9.40904 |
|      PD-Mk25 'Rebound' PDT  | 0.98338 |  0.0998734 |          4.28349 |
|     PD-Mk20 'Defender' PDT  |  2.4169 |  0.0888312 |           3.8099 |
| DEC-Stock/EA99 Active Decoy | 1.68144 |   0.086535 |          3.71142 |
|      MIS-Stock/SGM-H-3 Body | 1.72853 |  0.0491377 |          2.10748 |
|               RestoresTotal | 4.03047 |  0.0405394 |           1.7387 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
| Destroyed/Other |  92 |  285 |  0.127 |   0.395 |
|   NotEliminated | 252 |   93 |  0.349 |   0.129 |
|           Total | 344 |  378 |  0.476 |   0.524 |


## Cluster 13, 647 hulls

### Hull Counts

|                  Hulls | Count |
|------------------------|-------|
| Stock/Container Hauler |   419 |
|      Stock/Bulk Hauler |   225 |
|   Stock/Raines Frigate |     3 |


### Components

|                                 Names |  meanVal | proportion | scaledProportion |
|---------------------------------------|----------|------------|------------------|
|                   MIS-Stock/CM-4 Body |  104.229 |    0.97396 |          46.6146 |
|            MIS-Stock/Rocket Container |  10.0093 |   0.914173 |          43.7531 |
|   MIS-Stock/Decoy Container (Clipper) |  2.70015 |   0.788357 |          37.7315 |
|              MIS-Stock/Mine Container |  7.39413 |   0.739413 |           35.389 |
| MIS-Stock/Decoy Container (Line Ship) |  2.01391 |   0.547939 |          26.2249 |
|              MIS-Stock/S3 Sprint Mine |  7.13756 |   0.464588 |          22.2356 |
|                  MIS-Stock/SGM-2 Body |  68.5951 |   0.264729 |          12.6702 |
|                     MIS-Stock/S3 Mine | 0.990726 |   0.148483 |          7.10652 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
| Destroyed/Other |  278 |  82 |  0.127 |    0.43 |
|   NotEliminated |   72 | 215 |  0.332 |   0.111 |
|           Total |  297 | 350 |  0.541 |   0.459 |


## Cluster 14, 622 hulls

### Hull Counts

|                    Hulls | Count |
|--------------------------|-------|
|        Stock/Bulk Hauler |   458 |
|     Stock/Raines Frigate |   162 |
|   Stock/Container Hauler |     1 |
| Stock/Keystone Destroyer |     1 |


### Components

|                                 Names |  meanVal | proportion | scaledProportion |
|---------------------------------------|----------|------------|------------------|
|                       WEAP-250mm Gun  |  1537.47 |   0.139466 |          6.94325 |
|                 PD-P20 'Bastion' PDT  |  1.30225 |   0.068615 |          3.41597 |
| MIS-Stock/Decoy Container (Line Ship) | 0.250804 |  0.0656013 |          3.26593 |
|                   PD-P60 'Grazer' PDT | 0.401929 |  0.0419393 |          2.08793 |
|                         RestoresTotal |    4.209 |  0.0364715 |          1.81572 |
|                  PD-P11 'Pavise' PDT  | 0.384244 |  0.0317861 |          1.58246 |
|                         PD-250mm Gun  | 0.453376 |  0.0286411 |          1.42588 |
|            DEC-Stock/EA20 Flare Decoy |  1.34244 |  0.0269094 |          1.33967 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
|   NotEliminated | 283 |   79 |  0.455 |   0.127 |
| Destroyed/Other |  81 |  179 |   0.13 |   0.288 |
|           Total | 364 |  258 |  0.585 |   0.415 |


## Cluster 15, 536 hulls

### Hull Counts

|                      Hulls | Count |
|----------------------------|-------|
| Stock/Axford Heavy Cruiser |   475 |
|       Stock/Ocello Cruiser |    61 |


### Components

|                       Names |  meanVal | proportion | scaledProportion |
|-----------------------------|----------|------------|------------------|
|      MIS-Stock/SGM-H-2 Body |  20.5448 |   0.255712 |          14.7731 |
|      MIS-Stock/SGM-H-3 Body |  9.40112 |   0.198401 |          11.4621 |
|            WEAP-Beam Turret | 0.223881 |   0.162822 |          9.40663 |
|    PD-Mk29 'Stonewall' PDT  |    1.875 |   0.112618 |          6.50619 |
| DEC-Stock/EA99 Active Decoy |  2.82463 |   0.107919 |          6.23476 |
|        MIS-Stock/SGT-3 Body |  2.58396 |   0.106612 |          6.15925 |
|        PD-Mk90 'Aurora' PDT | 0.494403 |  0.0652067 |          3.76715 |
|     PD-Mk20 'Defender' PDT  |  2.10634 |   0.057473 |          3.32035 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
|   NotEliminated | 194 |   88 |  0.362 |   0.164 |
| Destroyed/Other |  43 |  211 |   0.08 |   0.394 |
|           Total | 237 |  299 |  0.442 |   0.558 |


## Cluster 16, 513 hulls

### Hull Counts

|                      Hulls | Count |
|----------------------------|-------|
|       Stock/Ocello Cruiser |   268 |
| Stock/Axford Heavy Cruiser |   245 |


### Components

|                    Names |  meanVal | proportion | scaledProportion |
|--------------------------|----------|------------|------------------|
|         WEAP-Beam Turret | 0.167641 |   0.116689 |          7.04367 |
|          WEAP-250mm Gun  |  1493.13 |   0.111708 |          6.74299 |
|     PD-Mk90 'Aurora' PDT | 0.709552 |  0.0895669 |          5.40649 |
| PD-Mk29 'Stonewall' PDT  |  1.32359 |   0.076087 |           4.5928 |
|   PD-Mk95 'Sarissa' PDT  | 0.645224 |  0.0688579 |          4.15644 |
|          EWAR-Omnijammer | 0.148148 |  0.0604134 |          3.64671 |
|   PD-Mk25 'Rebound' PDT  | 0.805068 |  0.0580954 |          3.50679 |
|  PD-Mk20 'Defender' PDT  |  1.45809 |  0.0380778 |          2.29847 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
| Destroyed/Other |  62 |  190 |  0.121 |    0.37 |
|   NotEliminated | 173 |   88 |  0.337 |   0.172 |
|           Total | 235 |  278 |  0.458 |   0.542 |


## Cluster 17, 367 hulls

### Hull Counts

|                    Hulls | Count |
|--------------------------|-------|
|     Stock/Raines Frigate |   282 |
| Stock/Keystone Destroyer |    85 |


### Components

|                  Names |  meanVal | proportion | scaledProportion |
|------------------------|----------|------------|------------------|
|        WEAP-120mm Gun  |  2246.58 |    0.20498 |          17.2954 |
|          PD-120mm Gun  |  2.80381 |   0.158576 |            13.38 |
| WEAP-Mk600 Beam Cannon | 0.201635 |  0.0520028 |          4.38779 |
| PD-Mk25 'Rebound' PDT  | 0.476839 |  0.0246167 |          2.07706 |
|    WEAP-Mk550 Railgun  |  5.17166 |   0.010877 |         0.917761 |
|      OriginalPointCost |  460.649 | 0.00654978 |         0.552645 |
|          RestoresTotal |  1.17166 | 0.00599036 |         0.505443 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
|   NotEliminated | 163 |   19 |  0.444 |   0.052 |
| Destroyed/Other |  67 |  118 |  0.183 |   0.322 |
|           Total | 230 |  137 |  0.627 |   0.373 |


## Cluster 18, 280 hulls

### Hull Counts

|             Hulls | Count |
|-------------------|-------|
| Stock/Bulk Hauler |   280 |


### Components

|                                 Names |  meanVal | proportion | scaledProportion |
|---------------------------------------|----------|------------|------------------|
|                         PD-100mm Gun  |  2.04286 |   0.132316 |          14.6332 |
|                    WEAP-400mm Plasma  |  294.375 |   0.127858 |          14.1401 |
|                       WEAP-100mm Gun  |  1936.97 |  0.0772762 |           8.5462 |
| MIS-Stock/Decoy Container (Line Ship) | 0.596429 |  0.0702271 |          7.76661 |
|                         RestoresTotal |  6.74286 |  0.0263019 |           2.9088 |
|                  PD-P11 'Pavise' PDT  | 0.592857 |  0.0220774 |           2.4416 |
|                       WEAP-250mm Gun  |  462.471 |  0.0188849 |          2.08853 |
|                WEAP-TE45 Mass Driver  |  26.7143 |  0.0174522 |          1.93009 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
| Destroyed/Other |   94 |  34 |  0.121 |   0.336 |
|   NotEliminated |   39 | 113 |  0.404 |   0.139 |
|           Total |  147 | 133 |  0.475 |   0.525 |


## Cluster 19, 219 hulls

### Hull Counts

|                        Hulls | Count |
|------------------------------|-------|
| Stock/Vauxhall Light Cruiser |   219 |


### Components

|                       Names | meanVal | proportion | scaledProportion |
|-----------------------------|---------|------------|------------------|
|      MIS-Stock/SGM-H-2 Body | 41.5708 |   0.211406 |          29.8923 |
|      MIS-Stock/SGM-H-3 Body | 16.0685 |   0.138554 |          19.5912 |
| DEC-Stock/EA99 Active Decoy | 2.80365 |  0.0437665 |          6.18846 |
|           OriginalPointCost | 2720.05 |  0.0230787 |          3.26327 |
|        MIS-Stock/SGT-3 Body | 1.29224 |  0.0217843 |          3.08024 |
|        MIS-Stock/SGM-1 Body | 4.45205 |  0.0178251 |          2.52043 |
|     PD-Mk20 'Defender' PDT  | 1.57991 |  0.0176135 |           2.4905 |
|        MIS-Stock/SGM-2 Body | 13.2329 |  0.0172863 |          2.44424 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
| Destroyed/Other |  106 |  24 |   0.11 |   0.484 |
|   NotEliminated |   24 |  65 |  0.297 |    0.11 |
|           Total |   89 | 130 |  0.594 |   0.406 |


## Cluster 20, 161 hulls

### Hull Counts

|                        Hulls | Count |
|------------------------------|-------|
|   Stock/Axford Heavy Cruiser |   104 |
|         Stock/Ocello Cruiser |    53 |
| Stock/Vauxhall Light Cruiser |     4 |


### Components

|                  Names |  meanVal | proportion | scaledProportion |
|------------------------|----------|------------|------------------|
|        WEAP-120mm Gun  |  1311.67 |  0.0525018 |           10.098 |
|          PD-120mm Gun  |  1.95031 |  0.0483896 |          9.30703 |
|       WEAP-Beam Turret |  0.15528 |  0.0339213 |          6.52427 |
|        WEAP-450mm Gun  |  471.503 |  0.0219487 |          4.22152 |
|   PD-Mk90 'Aurora' PDT | 0.509317 |  0.0201772 |          3.88078 |
| MIS-Stock/SGM-H-2 Body |  5.29814 |  0.0198077 |          3.80973 |
|    WEAP-300mm Railgun  |   15.528 |   0.018981 |          3.65071 |
| MIS-Stock/SGM-H-3 Body |  2.35404 |  0.0149224 |          2.87011 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
|   NotEliminated |   28 |  54 |  0.335 |   0.174 |
| Destroyed/Other |   54 |  25 |  0.155 |   0.335 |
|           Total |   79 |  82 |  0.509 |   0.491 |


## Cluster 21, 156 hulls

### Hull Counts

|                  Hulls | Count |
|------------------------|-------|
|      Stock/Bulk Hauler |   155 |
| Stock/Container Hauler |     1 |


### Components

|                                 Names |  meanVal | proportion | scaledProportion |
|---------------------------------------|----------|------------|------------------|
|                         PD-100mm Gun  |     4.25 |   0.153366 |          30.4431 |
|                       WEAP-100mm Gun  |   4378.1 |  0.0973141 |          19.3169 |
|                    WEAP-400mm Plasma  |  310.224 |  0.0750702 |          14.9014 |
| MIS-Stock/Decoy Container (Line Ship) | 0.448718 |  0.0294365 |          5.84315 |
|              MIS-Stock/Mine Container | 0.717949 |  0.0173107 |          3.43617 |
|                 PD-P20 'Bastion' PDT  |  1.20513 |  0.0159255 |           3.1612 |
|            DEC-Stock/EA20 Flare Decoy |  2.91026 |   0.014631 |          2.90425 |
|                         RestoresTotal |  6.38462 |  0.0138753 |          2.75426 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
| Destroyed/Other |   70 |  30 |  0.192 |   0.449 |
|   NotEliminated |   11 |  45 |  0.288 |   0.071 |
|           Total |   75 |  81 |  0.519 |   0.481 |


## Cluster 22, 155 hulls

### Hull Counts

|             Hulls | Count |
|-------------------|-------|
| Stock/Bulk Hauler |   108 |
| Stock/Bulk Feeder |    35 |
|     Stock/Tugboat |    12 |


### Components

|                                 Names |  meanVal | proportion | scaledProportion |
|---------------------------------------|----------|------------|------------------|
|                       WEAP-100mm Gun  |  8520.24 |   0.188169 |          37.5926 |
|                         PD-100mm Gun  |   3.2129 |   0.115198 |          23.0143 |
|                    WEAP-400mm Plasma  |  354.761 |  0.0852973 |          17.0407 |
| MIS-Stock/Decoy Container (Line Ship) | 0.393548 |  0.0256518 |          5.12473 |
|                 MIS-Stock/S3 Net Mine | 0.419355 |  0.0177547 |          3.54705 |
|                 PD-P20 'Bastion' PDT  |  1.27742 |  0.0167726 |          3.35083 |
|                     MIS-Stock/S3 Mine | 0.419355 |  0.0150568 |          3.00805 |
|            DEC-Stock/EA20 Flare Decoy |  2.56774 |  0.0128263 |          2.56245 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
| Destroyed/Other |   63 |  25 |  0.161 |   0.406 |
|   NotEliminated |   10 |  57 |  0.368 |   0.065 |
|           Total |   82 |  73 |  0.471 |   0.529 |


## Cluster 23, 97 hulls

### Hull Counts

|             Hulls | Count |
|-------------------|-------|
| Stock/Bulk Feeder |    75 |
|     Stock/Tugboat |    22 |


### Components

|                    Names |  meanVal | proportion | scaledProportion |
|--------------------------|----------|------------|------------------|
|          WEAP-100mm Gun  |  4644.85 |  0.0641961 |          20.4938 |
|            PD-100mm Gun  |   1.4433 |  0.0323849 |          10.3385 |
|       WEAP-400mm Plasma  |  140.928 |  0.0212049 |          6.76938 |
|   WEAP-TE45 Mass Driver  |  38.3505 | 0.00867944 |           2.7708 |
| MIS-Stock/S3 Sprint Mine | 0.618557 | 0.00603622 |          1.92698 |
|    PD-P20 'Bastion' PDT  | 0.721649 | 0.00592969 |          1.89298 |
| MIS-Stock/Mine Container | 0.329897 |  0.0049459 |          1.57892 |
|     PD-P11 'Pavise' PDT  | 0.371134 | 0.00478787 |          1.52847 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
|   NotEliminated |  17 |    2 |  0.175 |   0.021 |
| Destroyed/Other |  32 |   46 |   0.33 |   0.474 |
|           Total |  49 |   48 |  0.505 |   0.495 |


## Cluster 24, 96 hulls

### Hull Counts

|                        Hulls | Count |
|------------------------------|-------|
| Stock/Vauxhall Light Cruiser |    76 |
|     Stock/Solomon Battleship |    12 |
|   Stock/Axford Heavy Cruiser |     8 |


### Components

|                       Names | meanVal | proportion | scaledProportion |
|-----------------------------|---------|------------|------------------|
|             WEAP-120mm Gun  | 3389.29 |  0.0808917 |          26.0926 |
|               PD-120mm Gun  | 4.16667 |  0.0616428 |          19.8836 |
|      PD-Mk25 'Rebound' PDT  | 1.23958 |  0.0167393 |          5.39948 |
|         WEAP-300mm Railgun  |   15.75 |  0.0114797 |          3.70291 |
| DEC-Stock/EA99 Active Decoy | 1.38542 | 0.00948036 |          3.05801 |
|     PD-Mk20 'Defender' PDT  | 1.83333 | 0.00895948 |          2.88999 |
|      MIS-Stock/SGM-H-2 Body | 3.59375 | 0.00801133 |          2.58416 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
| Destroyed/Other |  15 |   32 |  0.156 |   0.333 |
|   NotEliminated |  33 |   16 |  0.344 |   0.167 |
|           Total |  48 |   48 |    0.5 |     0.5 |


## Cluster 25, 68 hulls

### Hull Counts

|                    Hulls | Count |
|--------------------------|-------|
|     Stock/Raines Frigate |    55 |
| Stock/Keystone Destroyer |    10 |
|  Stock/Sprinter Corvette |     3 |


### Components

|                       Names |   meanVal | proportion | scaledProportion |
|-----------------------------|-----------|------------|------------------|
|             WEAP-120mm Gun  |   4954.78 |  0.0837639 |          38.1446 |
|         WEAP-Mk550 Railgun  |   112.941 |  0.0440125 |          20.0425 |
|               PD-120mm Gun  |   2.52941 |  0.0265064 |          12.0705 |
|        MIS-Stock/SGM-1 Body |   3.23529 | 0.00402208 |          1.83159 |
| DEC-Stock/EA99 Active Decoy |  0.323529 | 0.00156818 |         0.714122 |
|      WEAP-Mk600 Beam Cannon | 0.0294118 | 0.00140548 |         0.640031 |
|           OriginalPointCost |    508.75 | 0.00134031 |         0.610353 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
| Destroyed/Other |  27 |   22 |  0.397 |   0.324 |
|   NotEliminated |  14 |    5 |  0.206 |   0.074 |
|           Total |  41 |   27 |  0.603 |   0.397 |


## Cluster 26, 37 hulls

### Hull Counts

|                  Hulls | Count |
|------------------------|-------|
|      Stock/Bulk Hauler |    21 |
|      Stock/Bulk Feeder |    13 |
|   Stock/Ocello Cruiser |     2 |
| Stock/Container Hauler |     1 |


### Components

|                      Names |  meanVal | proportion | scaledProportion |
|----------------------------|----------|------------|------------------|
|            WEAP-100mm Gun  |  17381.1 |  0.0916313 |           76.688 |
|              PD-100mm Gun  |  3.48649 |  0.0298404 |           24.974 |
|     WEAP-TE45 Mass Driver  |  157.946 |  0.0136351 |          11.4115 |
|            EWAR-Omnijammer | 0.351351 |  0.0103339 |          8.64861 |
|       PD-P11 'Pavise' PDT  |  2.08108 |  0.0102407 |          8.57066 |
|         WEAP-400mm Plasma  |  120.054 | 0.00689042 |          5.76672 |
|                 PD-Jammers | 0.108108 | 0.00430108 |          3.59965 |
| DEC-Stock/EA12 Chaff Decoy |  9.72973 | 0.00389181 |          3.25713 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
| Destroyed/Other |   15 |   9 |  0.243 |   0.405 |
|   NotEliminated |    3 |  10 |   0.27 |   0.081 |
|           Total |   19 |  18 |  0.486 |   0.514 |


## Cluster 27, 36 hulls

### Hull Counts

|                        Hulls | Count |
|------------------------------|-------|
| Stock/Vauxhall Light Cruiser |    29 |
|   Stock/Axford Heavy Cruiser |     3 |
|     Stock/Solomon Battleship |     2 |
|         Stock/Ocello Cruiser |     1 |
|     Stock/Keystone Destroyer |     1 |


### Components

|                       Names |   meanVal | proportion | scaledProportion |
|-----------------------------|-----------|------------|------------------|
|             WEAP-120mm Gun  |   7150.67 |  0.0639989 |          55.0498 |
|               PD-120mm Gun  |      3.75 |  0.0208044 |          17.8953 |
|         WEAP-300mm Railgun  |   75.1667 |   0.020545 |          17.6721 |
|     PD-Mk20 'Defender' PDT  |   2.38889 | 0.00437793 |          3.76575 |
|      PD-Mk25 'Rebound' PDT  |  0.805556 | 0.00407934 |          3.50891 |
|            WEAP-Beam Turret | 0.0833333 | 0.00407056 |          3.50136 |
| DEC-Stock/EA99 Active Decoy |   1.44444 | 0.00370661 |           3.1883 |
|      MIS-Stock/SGM-H-2 Body |   3.22222 | 0.00269367 |            2.317 |


### Hull Outcome vs WinRate

|      Eliminated | Win | Loss | WinPct | LossPct |
|-----------------|-----|------|--------|---------|
|   NotEliminated |  11 |    4 |  0.306 |   0.111 |
| Destroyed/Other |   8 |   13 |  0.222 |   0.361 |
|           Total |  19 |   17 |  0.528 |   0.472 |


## Cluster 28, 32 hulls

### Hull Counts

|                Hulls | Count |
|----------------------|-------|
| Stock/Ocello Cruiser |    32 |


### Components

|                 Names | meanVal | proportion | scaledProportion |
|-----------------------|---------|------------|------------------|
|         PD-100mm Gun  | 3.34375 |  0.0247513 |          23.9516 |
|       WEAP-100mm Gun  | 5240.97 |  0.0238961 |           23.124 |
|    WEAP-400mm Plasma  | 195.812 | 0.00971981 |          9.40574 |
|  PD-P11 'Pavise' PDT  | 1.71875 |  0.0073148 |          7.07844 |
|            PD-Jammers | 0.15625 | 0.00537634 |          5.20262 |
| MIS-Stock/S3 Net Mine |  0.5625 | 0.00491669 |          4.75782 |
|       EWAR-Omnijammer |  0.1875 | 0.00476948 |          4.61536 |
|  PD-Mk90 'Aurora' PDT |  0.5625 | 0.00442913 |          4.28602 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
|   NotEliminated |    5 |  10 |  0.312 |   0.156 |
| Destroyed/Other |   14 |   3 |  0.094 |   0.438 |
|           Total |   13 |  19 |  0.594 |   0.406 |


## Cluster 29, 28 hulls

### Hull Counts

|                        Hulls | Count |
|------------------------------|-------|
| Stock/Vauxhall Light Cruiser |    16 |
|     Stock/Solomon Battleship |     4 |
|         Stock/Ocello Cruiser |     3 |
|   Stock/Axford Heavy Cruiser |     3 |
|            Stock/Bulk Hauler |     2 |


### Components

|                       Names |  meanVal | proportion | scaledProportion |
|-----------------------------|----------|------------|------------------|
|             WEAP-250mm Gun  |  5776.68 |  0.0235889 |          26.0876 |
| DEC-Stock/EA99 Active Decoy |  3.60714 | 0.00719937 |          7.96199 |
|             WEAP-120mm Gun  |  903.286 | 0.00628792 |          6.95399 |
|               PD-250mm Gun  |  1.82143 | 0.00517977 |          5.72845 |
|     PD-Mk20 'Defender' PDT  |  2.35714 |  0.0033598 |           3.7157 |
|             EWAR-Omnijammer | 0.142857 | 0.00317965 |          3.51647 |
|  DEC-Stock/EA20 Flare Decoy |  3.39286 | 0.00306155 |          3.38586 |
|      MIS-Stock/SGM-H-3 Body |     2.25 | 0.00248051 |          2.74327 |


### Hull Outcome vs WinRate

|      Eliminated | Loss | Win | WinPct | LossPct |
|-----------------|------|-----|--------|---------|
| Destroyed/Other |   19 |   2 |  0.071 |   0.679 |
|   NotEliminated |    3 |   4 |  0.143 |   0.107 |
|           Total |    6 |  22 |  0.786 |   0.214 |


