using HTTP
using JSON
using HTTP.URIs


function get_playtime(_steamid::String, appid::Int, api_key::String)
    base_url = "http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/"
    params = Dict(
        "key" => api_key,
        "steamid" => _steamid,
        "format" => "json"
    )

    encoded_params = URIs.escapeuri(params)  # URL-encode the parameters

    full_url = "$base_url?$encoded_params"
    r = HTTP.get(full_url)
    data = JSON.parse(String(r.body))
    
    if haskey(data, "response") && haskey(data["response"], "games")
        games = data["response"]["games"]
        
        for game in games
            if game["appid"] == appid
                playtime_minutes = game["playtime_forever"]
                playtime_hours = playtime_minutes / 60
                return playtime_hours
            end
        end
        
        return 0.0  # Game not found in the user's library
    else
        return 0.0  # Invalid response or user not found
    end
end

# Replace with your SteamID, AppID, and API Key
api_key = "991E0D61568612DA256C7C9EC1E9BC61"
appid = 887570
steamid = "76561198041884307"


playtime_hours = get_playtime(steamid, appid, api_key)
# println("Playtime for AppID $appid: $playtime_hours hours")

AllTeamReports =    deepcopy(AllReports[2])
unique(AllTeamReports.AccountId)

ids = unique(AllTeamReports.AccountId)
playtime_hours = fill(0.0,size(ids,1))

Threads.@threads for i in 1:size(ids,1)

    playtime_hours[i] = get_playtime(ids[i], appid, api_key)

end
playtime_hours
PlayerPlaytime = DataFrame(AccountId = ids , HoursPlayed = playtime_hours)


# filter(x->x != 0,PlayerPlaytime.HoursPlayed)
jldsave("PlayerPlaytime.jld2";df = PlayerPlaytime)

median(filter(x->x != 0,PlayerPlaytime.HoursPlayed))
histogram((filter(x->x != 0,PlayerPlaytime.HoursPlayed)))