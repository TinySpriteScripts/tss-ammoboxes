# |‾‾‾|/‾‾‾\ /‾‾‾\
#   |  \__‾‾\\__‾‾\
#   |   |___/ |___/
# tinysprite.dev

# [`tss-ammoboxes`] by [TinySprite](https://tinysprite.dev/) | [Discord](https://discord.gg/ZMFfC54FdJ)

Sell your ammo in bulk. Players buy an ammo box and unpack it into ammo, one use at a time.

---

## 📦 Dependencies
- [tss_bridge](https://github.com/TinySpriteScripts/tss_bridge) (**required**) - handles framework, inventory, notify and progressbar

Works with any framework and inventory supported by `tss_bridge` (QBCore, Qbox, ESX / qb-inventory, ox_inventory, ...).

---

## 🧰 Installation

> **This script requires [`tss_bridge`](https://github.com/TinySpriteScripts/tss_bridge).** Start your framework and inventory, then `tss_bridge`, then `tss-ammoboxes`.

1. Place `tss-ammoboxes` in your `[tinysprite]` folder and make sure it starts after `tss_bridge`:
   ```cfg
   ensure tss_bridge
   ensure [tinysprite]
   ```
2. Add the ammo box items to your inventory (examples below). Each box in `Config.AmmoBoxes` must exist as a **useable** item.
3. Adjust `config.lua` - ammo type and amount per box, number of uses (`DefaultUses`), unpacking time and animation.

### qb-inventory (`qb-core/shared/items.lua`)
```lua
pistolammobox  = { name = 'pistolammobox',  label = 'Pistol Ammo Box',  weight = 200, type = 'item', image = 'pistol_ammo.png',  unique = false, useable = true, shouldClose = true, description = 'Bulk Pistol Ammo' },
smgammobox     = { name = 'smgammobox',     label = 'SMG Ammo Box',     weight = 200, type = 'item', image = 'smg_ammo.png',     unique = false, useable = true, shouldClose = true, description = 'Bulk SMG Ammo' },
rifleammobox   = { name = 'rifleammobox',   label = 'Rifle Ammo Box',   weight = 200, type = 'item', image = 'rifle_ammo.png',   unique = false, useable = true, shouldClose = true, description = 'Bulk Rifle Ammo' },
shotgunammobox = { name = 'shotgunammobox', label = 'Shotgun Ammo Box', weight = 200, type = 'item', image = 'shotgun_ammo.png', unique = false, useable = true, shouldClose = true, description = 'Bulk Shotgun Ammo' },
sniperammobox  = { name = 'sniperammobox',  label = 'Sniper Ammo Box',  weight = 200, type = 'item', image = 'rifle_ammo.png',   unique = false, useable = true, shouldClose = true, description = 'Bulk Sniper Ammo' },
```

### ox_inventory (`ox_inventory/data/items.lua`)
```lua
['pistolammobox']  = { label = 'Pistol Ammo Box',  weight = 200, stack = true, close = true, description = 'Bulk Pistol Ammo' },
['smgammobox']     = { label = 'SMG Ammo Box',     weight = 200, stack = true, close = true, description = 'Bulk SMG Ammo' },
['rifleammobox']   = { label = 'Rifle Ammo Box',   weight = 200, stack = true, close = true, description = 'Bulk Rifle Ammo' },
['shotgunammobox'] = { label = 'Shotgun Ammo Box', weight = 200, stack = true, close = true, description = 'Bulk Shotgun Ammo' },
['sniperammobox']  = { label = 'Sniper Ammo Box',  weight = 200, stack = true, close = true, description = 'Bulk Sniper Ammo' },
```

### Shops
Add the boxes to any shop like a normal item. New boxes start with `Config.DefaultUses` uses, so no `info`/metadata is needed. To sell a box with a different number of uses, give it `uses` metadata, e.g. `info = { uses = 8 }` (qb) / `metadata = { uses = 8 }` (ox).

No inventory HTML or server edits are needed. Opened boxes are split off from the stack and show their remaining uses in their description.

---

## ✨ Features
 - Bulk ammo boxes that are unpacked one use at a time
 - Configurable ammo type, ammo per use and number of uses per box
 - Configurable unpacking time and animation
 - Server-side validation of every unpack (box must still be in the same slot, unpack time must have passed)
 - English and Dutch locales (`Config.Lan`)

---

## 📜 History
- v1.0 - Created as MK-AmmoBoxes by McKleans-Scripts (May 2023)
- v1.1 - Config options and cleanup, thanks to Oosayeroo
- v1.2 - Give ammo fix, thanks to Sayer
- v2.0.0 - Rebuilt as TSS-AmmoBoxes on `tss_bridge` (multi-framework/inventory support, server-validated unpacking, per-box uses without inventory edits)

---

## 🔧 Support
Need help? Join our Discord: [Join Support Server](https://discord.gg/ZMFfC54FdJ)

**© TinySprite** — Quality resources built for FiveM servers.
