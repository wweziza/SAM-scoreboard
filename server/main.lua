-- server/main.lua
local function GetPlayersData()
    local players = {}
    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        local score = 0 -- You might need to implement a scoring system
        local ping = GetPlayerPing(playerId)
        table.insert(players, {id = playerId, name = name, score = score, ping = ping})
    end
    return players
end

RegisterNetEvent('SAM-scoreboard:Server:requestScoreboard')
AddEventHandler('SAM-scoreboard:Server:requestScoreboard', function()
    local source = source
    local playerData = GetPlayersData()
    local serverName = GetConvar("sv_hostname", "FiveM Server")
    TriggerClientEvent("SAM-scoreboard:Client:updateScoreboard", source, playerData, serverName)
end)

RegisterNetEvent('SAM-scoreboard:Server:onScoreboardPlayerClicked')
AddEventHandler('SAM-scoreboard:Server:onScoreboardPlayerClicked', function(clickedPlayerId, clickedPlayerName, clickedPlayerPing)
    local source = source
    TriggerClientEvent('chat:addMessage', source, {
        color = {255, 255, 0},
        multiline = true,
        args = {"Scoreboard", "Clicked player: ID " .. clickedPlayerId .. ", Name: " .. clickedPlayerName .. ", Ping: " .. clickedPlayerPing}
    })
end)

RegisterCommand("testscoreboard", function(source, args, rawCommand)
    TriggerClientEvent("SAM-scoreboard:toggleScoreboard", source)
end, false)
