local players = {}

-- Simulate player data (replace this with your actual player data retrieval)
local function GetPlayersData()
    players = {
        {id = 1, name = "Player1", score = 5000, ping = 50},
        {id = 2, name = "Player2", score = 6000, ping = 75},
        -- Add more mock players as needed
    }
    return players
end

RegisterNetEvent("requestScoreboard")
AddEventHandler("requestScoreboard", function()
    local source = source
    local playerData = GetPlayersData()
    TriggerClientEvent("updateScoreboard", source, playerData)
end)

RegisterCommand("testscoreboard", function(source, args, rawCommand)
    TriggerClientEvent("toggleScoreboard", source)
end, false)