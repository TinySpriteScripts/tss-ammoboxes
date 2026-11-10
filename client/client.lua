---@type TSSClientModules
local TSS = exports.tss_bridge:GetModules({ 'ProgressBar', 'Notify' }, {
    Notify = Config.TSS.Notify, ProgressBar = Config.TSS.ProgressBar, Debug = Config.Debug,
})

local resource = GetCurrentResourceName()
local busy = false

local function L(section, key)
    local lang = Loc[Config.Lan] or Loc.en
    return lang[section] and lang[section][key] or key
end

-- Sent by the server when a player uses an ammo box; the server decides the duration.
RegisterNetEvent(resource .. ':client:Unpack', function(duration)
    if busy then return end
    busy = true

    local anim = Config.Animation
    local success = TSS.ProgressBar.Start({
        label = L('progress', 'unpacking'),
        duration = duration,
        canCancel = true,
        disableMovement = true,
        disableCarMovement = true,
        disableCombat = true,
        dict = anim.dict,
        anim = anim.clip,
        flag = anim.flag,
    })
    ClearPedTasks(PlayerPedId())

    TriggerServerEvent(resource .. ':server:FinishUnpack', success == true)
    if not success then
        TSS.Notify.Send({ message = L('error', 'cancelled'), type = 'error' })
    end
    busy = false
end)
