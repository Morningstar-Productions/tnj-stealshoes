local qbCore = exports['qb-core']:GetCoreObject()
local shoeid = nil

---@param playerId number
local function isTargetDead(playerId)
    return lib.callback.await('tnj-stealshoes:server:isPlayerDead', false, playerId)
end

---@param player number
---@param distance number
---@param maxDistance? number
---@return boolean
local function isPlayerTooFar(player, distance, maxDistance)
    if not player or distance >= (maxDistance or 2.5) then
        return true
    end
    return false
end

local function PlayerCloseMenu()
    local player, distance = qbCore.Functions.GetClosestPlayer()
    local playerPed = GetPlayerPed(player)
    local playerId = GetPlayerServerId(player)
    if not isPlayerTooFar(player, distance) then
        if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) or isTargetDead(playerId) then

            if shoeid then return end
            shoeid = exports['qb-radialmenu']:AddOption({
                id = 'stealshoes',
                title = "Steal Shoes",
                icon = "shoe-prints",
                type = "client",
                event = "tnj-stealshoes:client:TheftShoe",
                shouldClose = true,
            }, shoeid)
        end
    else
        if shoeid then
            exports['qb-radialmenu']:RemoveOption(shoeid)
            shoeid = nil
        end
    end
end

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', PlayerCloseMenu)

RegisterNetEvent('tnj-stealshoes:client:TheftShoe', function() -- This could be used in the radialmenu ;)
    if not IsPedRagdoll(cache.ped) then
        local player, distance = qbCore.Functions.GetClosestPlayer()
        if player and distance < 1.5 then
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(ped) then
                local oped = GetPlayerPed(player)
                local hasShoes = GetPedDrawableVariation(oped, 6)
                if hasShoes ~= 34 then
                    lib.requestAnimDict("random@domestic")
                    TaskPlayAnim(cache.ped, "random@domestic", "pickup_low", 8.00, -8.00, 500, 0, 0.00, 0, 0, 0)
                    TriggerServerEvent("tnj-stealshoes:server:TheftShoe", playerId)
                    SetPedComponentVariation(oped, 6, 34, 0, 2)
                else
                    qbCore.Functions.Notify("No shoes to been stolen!", "error")
                end
            else
                qbCore.Functions.Notify('You can\'t steal shoes in vehicle', "error")
            end
        else
            qbCore.Functions.Notify('No one nearby!', "error")
        end
    end
end)

RegisterNetEvent('tnj-stealshoes:client:StoleShoe', function(playerId)
    local hasShoes = GetPedDrawableVariation(cache.ped, 6)
    if hasShoes ~= 34 then
        if GetEntityModel(cache.ped) == `mp_m_freemode_01`  then
            SetPedComponentVariation(cache.ped, 6, 34, 0, 2)
        elseif GetEntityModel(cache.ped) == `mp_f_freemode_01`  then
            SetPedComponentVariation(cache.ped, 6, 34, 0, 2)
        end
        qbCore.Functions.Notify("Shoes got robbed lmao", 'primary')
        TriggerServerEvent("tnj-stealshoes:server:Complete", playerId)
    else
        qbCore.Functions.Notify("Someone tried to steal yo feet", 'primary')
    end
end)
