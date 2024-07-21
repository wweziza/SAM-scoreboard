local scoreboardVisible = false

RegisterNetEvent("toggleScoreboard")
AddEventHandler("toggleScoreboard", function()
    scoreboardVisible = not scoreboardVisible
    if scoreboardVisible then
        TriggerServerEvent("requestScoreboard")
        SendNUIMessage({
            type = "showScoreboard"
        })
        SetNuiFocus(true, true)
    else
        SendNUIMessage({
            type = "hideScoreboard"
        })
        SetNuiFocus(false, false)
    end
end)

RegisterNetEvent("updateScoreboard")
AddEventHandler("updateScoreboard", function(players)
    SendNUIMessage({
        type = "updateScoreboard",
        players = players
    })
end)

RegisterNUICallback("closeScoreboard", function(data, cb)
    scoreboardVisible = false
    SetNuiFocus(false, false)
    cb('ok')
end)