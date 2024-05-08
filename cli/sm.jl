using CSV, DataFrames

sm = CSV.read("sm.csv",DataFrame)

sm."Breakthrough 1"

names(sm)[20:end]


sm.All = string.(
        sm."Breakthrough 1",
        sm."Breakthrough 2",
        sm."Breakthrough 3",
        sm."Breakthrough 4",
        sm."Breakthrough 5",
        sm."Breakthrough 6",
        sm."Breakthrough 7",
        sm."Breakthrough 8",
        sm."Breakthrough 9",
        sm."Breakthrough 10",
        sm."Breakthrough 11",
        sm."Breakthrough 12",)

filter(x->
    contains(x.All,"Eternal Fusion") &&
    # contains(x.All,"Extractor AI") &&
    # contains(x.All,"Gem Architecture") &&
    # contains(x.All,"Global Support") &&
    contains(x.All,"Multispiral Architecture") &&
    contains(x.All,"Nano Refinement") &&
    contains(x.All,"Extractor AI") &&
    contains(x.All,"Superconducting Computing") &&
    contains(x.All,"") &&
    contains(x.All,"") &&
    contains(x.All,"") &&
    contains(x.All,"") 
    
    ,sm)

bt = sort(unique(sm."Breakthrough 1",))