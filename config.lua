-- TSS-AmmoBoxes by [TinySprite](https://tinysprite.dev/) | [Discord](https://discord.gg/ZMFfC54FdJ)
Config = {
    Lan = "en",                 -- "en", "nl"
    Debug = false,

    -- Presentation providers used through tss_bridge ("auto" follows the tss_bridge config)
    TSS = {
        Notify = "auto",        -- "auto", "ox", "qb", "okok", "tss", "native", ...
        ProgressBar = "auto",   -- "auto", "ox", "qb", "tss", ...
    },

    Duration = { min = 4000, max = 6000 },  -- Unpacking time in ms (random between min and max)
    Animation = {
        dict = "mp_arresting",
        clip = "a_uncuff",
        flag = 8,
    },

    DefaultUses = 4,            -- Uses a box has when it doesn't have a `uses` value in its metadata

    -- [box item] = { AmmoType = ammo item given, Amount = how many ammo items per use }
    AmmoBoxes = {
        ['pistolammobox']   = { AmmoType = 'pistol_ammo',   Amount = 1, },
        ['smgammobox']      = { AmmoType = 'smg_ammo',      Amount = 1, },
        ['rifleammobox']    = { AmmoType = 'rifle_ammo',    Amount = 1, },
        ['shotgunammobox']  = { AmmoType = 'shotgun_ammo',  Amount = 1, },
        ['sniperammobox']   = { AmmoType = 'sniper_ammo',   Amount = 1, },
    },
}
