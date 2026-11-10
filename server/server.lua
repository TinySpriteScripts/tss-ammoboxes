---@type TSSServerModules
local TSS = exports.tss_bridge:GetModules({ 'Inventory', 'Notify' }, Config.TSS)

local resource = GetCurrentResourceName()
local pending = {}

local function L(section, key)
    local lang = Loc[Config.Lan] or Loc.en
    return lang[section] and lang[section][key] or key
end

local function itemLabel(name)
    local items = TSS.Inventory.Items() or {}
    return items[name] and items[name].label or name
end

local function metadataOf(item)
    return type(item.metadata) == 'table' and item.metadata or type(item.info) == 'table' and item.info or {}
end

local function countOf(item)
    return tonumber(item.count or item.amount) or 1
end

---------- / Useable Items
CreateThread(function()
    local items = TSS.Inventory.Items() or {}
    for boxName in pairs(Config.AmmoBoxes) do
        if next(items) and not items[boxName] then
            print(("^1Error^7: ^2Ammo box item ^7'^6%s^7' ^2not found in your items^7"):format(boxName))
        else
            local ok, err = TSS.Inventory.CreateUseableItem(boxName, function(source, item)
                local slot = type(item) == 'table' and tonumber(item.slot)
                if not slot or pending[source] then return end
                local duration = math.random(Config.Duration.min, Config.Duration.max)
                pending[source] = { box = boxName, slot = slot, finishAt = GetGameTimer() + duration - 1000 }
                TriggerClientEvent(resource .. ':client:Unpack', source, duration)
            end)
            if not ok then
                print(("^1Error^7: ^2Could not register ^6%s^7 (%s)"):format(boxName, tostring(err)))
            end
        end
    end
end)

RegisterNetEvent(resource .. ':server:FinishUnpack', function(completed)
    local src = source
    local use = pending[src]
    pending[src] = nil
    if not use or completed ~= true or GetGameTimer() < use.finishAt then return end

    local box = Config.AmmoBoxes[use.box]
    local item = TSS.Inventory.GetSlot(src, use.slot)
    if not box or not item or item.name ~= use.box then
        TSS.Notify.Send(src, { message = L('error', 'missingbox'), type = 'error' })
        return
    end

    local amount = box.Amount or 1
    if not TSS.Inventory.CanCarry(src, box.AmmoType, amount) then
        TSS.Notify.Send(src, { message = L('error', 'cantcarry'), type = 'error' })
        return
    end

    local metadata = metadataOf(item)
    local uses = math.floor(tonumber(metadata.uses) or Config.DefaultUses)
    local remaining = uses - 1

    -- Take the used box off the player first so a failed step can't duplicate ammo.
    if not TSS.Inventory.Remove(src, use.box, 1, nil, use.slot, 'ammobox_unpack') then
        TSS.Notify.Send(src, { message = L('error', 'missingbox'), type = 'error' })
        return
    end

    -- A partly used box goes back as its own stack so other boxes keep their uses.
    if remaining > 0 then
        local opened = {}
        for k, v in pairs(metadata) do opened[k] = v end
        opened.uses = remaining
        opened.description = ("%d uses left"):format(remaining)
        local slot = countOf(item) == 1 and use.slot or nil
        if not TSS.Inventory.Add(src, use.box, 1, opened, slot, 'ammobox_unpack') then
            TSS.Inventory.Add(src, use.box, 1, metadata, nil, 'ammobox_refund')
            return
        end
    end

    if not TSS.Inventory.Add(src, box.AmmoType, amount, nil, nil, 'ammobox_unpack') then
        TSS.Notify.Send(src, { message = L('error', 'cantcarry'), type = 'error' })
        return
    end

    local label = itemLabel(box.AmmoType)
    if remaining > 0 then
        TSS.Notify.Send(src, { message = L('success', 'unpacked'):format(amount, label, remaining), type = 'success' })
    else
        TSS.Notify.Send(src, { message = L('success', 'empty'):format(amount, label), type = 'success' })
    end
end)

AddEventHandler('playerDropped', function()
    pending[source] = nil
end)
