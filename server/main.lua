local qbCore = exports['qb-core']:GetCoreObject()

lib.callback.register('tnj-stealshoes:server:isPlayerDead', function(_, playerId)
    local player = qbCore.Functions.GetPlayer(playerId)
    return player.PlayerData.metadata.idead
end)

RegisterNetEvent('tnj-stealshoes:server:TheftShoe', function(playerId)
    local source = source
    local Player = qbCore.Functions.GetPlayer(source)
    local Receiver = qbCore.Functions.GetPlayer(playerId)
    if Receiver then
        TriggerClientEvent("tnj-stealshoes:client:StoleShoe", Receiver.PlayerData.source, Player.PlayerData.source)
    end
end)

RegisterNetEvent("tnj-stealshoes:server:Complete", function(playerId)
    local source = source
    local Player = qbCore.Functions.GetPlayer(source)
    local Receiver = qbCore.Functions.GetPlayer(playerId)
    if Receiver then
        Receiver.Functions.AddItem("weapon_shoe", 1)
        TriggerClientEvent('inventory:client:ItemBox', Receiver.PlayerData.source, qbCore.Shared.Items["weapon_shoe"], 'add')
    end
end)