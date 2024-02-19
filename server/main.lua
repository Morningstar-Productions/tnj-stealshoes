local qbCore = exports['qb-core']:GetCoreObject()

lib.callback.register('tnj-stealshoes:server:isPlayerDead', function(_, playerId)
    local player = qbCore.Functions.GetPlayer(playerId)
    return player.PlayerData.metadata.isdead
end)

lib.callback.register('tnj-stealshoes:server:stealShoe', function(playerId)
    local source = source
    local Player = qbCore.Functions.GetPlayer(source)
    local Receiver = qbCore.Functions.GetPlayer(playerId)

    if Receiver then
        lib.callback("tnj-stealshoes:client:StoleShoe", Receiver.PlayerData.source, false, Player.PlayerData.source)
        return true
    end

    return false
end)

lib.callback.register("tnj-stealshoes:server:Complete", function(playerId)
    if exports.ox_inventory:CanCarryItem(playerId, 'WEAPON_SHOE', 1) then
        exports.ox_inventory:AddItem(playerId, 'WEAPON_SHOE', 1)
        return true
    end

    return false
end)