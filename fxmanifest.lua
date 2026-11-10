fx_version "cerulean"
game "gta5"
lua54 'yes'

name "TSS-AmmoBoxes"
author "TinySprite"
description "Bulk ammo boxes that players unpack into ammo"
version "2.0.0"
discord "https://discord.gg/ZMFfC54FdJ"
tebex "https://tinysprite.dev/"

dependency "tss_bridge"

shared_scripts {
    'locales/*.lua',
    'config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}
