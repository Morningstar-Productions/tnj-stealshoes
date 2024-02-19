---@param playerId number
local function isTargetDead(playerId)
    return lib.callback.await('tnj-stealshoes:server:isPlayerDead', false, playerId)
end

local function stealShoes() -- This could be used in the radialmenu ;)
    if IsPedRagdoll(cache.ped) then return end

    local player = lib.getClosestPlayer(GetEntityCoords(cache.ped), 1.5, false)

    if not player then return lib.notify({ description = 'No one nearby!', type = 'error', duration = 5000 }) end

    local playerId = GetPlayerServerId(player)

    if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(cache.ped) then
        local oped = GetPlayerPed(player)
        local hasShoes = GetPedDrawableVariation(oped, 6)
        if hasShoes ~= 34 then
            lib.requestAnimDict("random@domestic")
            TaskPlayAnim(cache.ped, "random@domestic", "pickup_low", 8.00, -8.00, 500, 0, 0.00, false, false, false)

            local getShoe = lib.callback.await('tnj-stealshoes:server:stealShoe', false, playerId)
            
            if getShoe then SetPedComponentVariation(oped, 6, 34, 0, 2) end
        else
            lib.notify({ description = "No shoes to been stolen!", type = "error" })
        end
    else
        lib.notify({ description = 'You can\'t steal shoes in vehicle', type = "error" })
    end
end

local function PlayerCloseMenu()
    local player = lib.getClosestPlayer(GetEntityCoords(cache.ped), 2.5, false)
    local playerPed = GetPlayerPed(player)
    local playerId = GetPlayerServerId(player)

    if not player then
        lib.removeRadialItem('stealShoes')
    end

    if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) or isTargetDead(playerId) then
        lib.addRadialItem({
            id = 'stealshoes',
            label = "Steal Shoes",
            icon = "shoe-prints",
            onSelect = function()
                stealShoes()
            end,
            keepOpen = false,
        })
    end
end

RegisterNetEvent('mp-radialitems:addRadialItem', function()
    if isTargetDead(cache.ped) then return end

    PlayerCloseMenu()
end)

lib.callback.register('tnj-stealshoes:client:StoleShoe', function(playerId)
    local hasShoes = GetPedDrawableVariation(cache.ped, 6)

    if hasShoes == 34 then return lib.notify({ description = "Someone tried to steal yo feet", type = 'inform'}) end

    if GetEntityModel(cache.ped) == `mp_m_freemode_01`  then
        SetPedComponentVariation(cache.ped, 6, 34, 0, 2)
    elseif GetEntityModel(cache.ped) == `mp_f_freemode_01`  then
        SetPedComponentVariation(cache.ped, 6, 34, 0, 2)
    end

    local hasShoe = lib.callback.await("tnj-stealshoes:server:Complete", false, playerId)

    if hasShoe then lib.notify({ description = "Shoes got robbed lmao", type = 'inform'}) end
end)
