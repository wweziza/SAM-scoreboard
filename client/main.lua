local scoreboardVisible = false

function HandlePlayerClick(playerId, playerName, ping)
    TriggerServerEvent('SAM-scoreboard:Server:onScoreboardPlayerClicked', playerId, playerName, ping)
    CloseScoreboard()
end


RegisterNUICallback('SAM-scoreboard:Client:playerClicked', function(data, cb)
    HandlePlayerClick(data.id, data.name, data.ping)
    cb('ok')
end)


function ShowScoreboard()
    if not scoreboardVisible then
        TriggerServerEvent('SAM-scoreboard:Server:requestScoreboard')
        SendNUIMessage({
            type = "showScoreboard"
        })
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true) -- to make the key still able to keep input
        scoreboardVisible = true
    end
end


function CloseScoreboard()
    if scoreboardVisible then
        scoreboardVisible = false
        SendNUIMessage({
            type = "hideScoreboard"
        })
        SetNuiFocus(false, false)
    end
end

RegisterNetEvent('SAM-scoreboard:Client:updateScoreboard')
AddEventHandler('SAM-scoreboard:Client:updateScoreboard', function(players)
    SendNUIMessage({
        type = "updateScoreboard",
        players = players
    })
end)

RegisterNetEvent("SAM-scoreboard:toggleScoreboard")
AddEventHandler("SAM-scoreboard:toggleScoreboard", function()
    if scoreboardVisible then
        CloseScoreboard()
    else
        ShowScoreboard()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if IsControlJustPressed(0, 246) then  -- Y key: 246
            TriggerEvent("SAM-scoreboard:toggleScoreboard")
        end
    end
end)
