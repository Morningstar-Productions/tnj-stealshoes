# tnj-stealshoes

*the model is standalone this just has the steal shoes in qbcore*

## LICENSE
This project does not contain a license, therefore you are not allowed to add one and claim it as yours. You are not allowed to sell this nor re-distribute it, if an issue arises, we will proceed to file a DMCA takedown request. You are not allowed to change/add a license unless given permission by T&J Services (Jay). If you want to modify _(does not apply if you want to use it for personal purposes)_ or make an agreement, you can contact T&J Services (Jay). Pull requests are accepted as long as they do not contain breaking changes. You can read more about unlicensed repositories [here](https://opensource.stackexchange.com/questions/1720/what-can-i-assume-if-a-publicly-published-project-has-no-license) if questions remain.


### Insert this into ox_inventory/data/weapons.lua
```lua
		['WEAPON_SHOE'] = {
			label = 'Stolen Shoes',
			weight = 300,
			throwable = true,
			description = 'These are not yours, bro.',
		},
```

### Insert this into ox_lib/resource/interface/client/radial.lua (Replace Keybind)

```lua
lib.addKeybind({
    name = 'ox_lib-radial',
    description = 'Open radial menu',
    defaultKey = 'z',
    onPressed = function()
        if isDisabled then return end

        if isOpen then
            return lib.hideRadial()
        end

        if #menuItems == 0 or IsNuiFocused() or IsPauseMenuActive() then return end

        isOpen = true

        SendNUIMessage({
            action = 'openRadialMenu',
            data = {
                items = menuItems
            }
        })

        lib.setNuiFocus(true)
        SetCursorLocation(0.5, 0.5)

        TriggerEvent('mp-radialitems:addRadialItem')

        while isOpen do
            DisablePlayerFiring(cache.playerId, true)
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(2, 199, true)
            DisableControlAction(2, 200, true)
            Wait(0)
        end
    end,
    -- onReleased = lib.hideRadial,
})
```
