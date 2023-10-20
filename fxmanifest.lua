fx_version 'cerulean'
game 'gta5'

author 'jay ;)'
description 'tnj development https://discord.gg/GUhYGu999z'

data_file 'WEAPONCOMPONENTSINFO_FILE' 'metas/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'metas/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'metas/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'metas/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' 'metas/weapons.meta'

shared_scripts { '@ox_lib/init.lua' }
client_script 'client/*.lua'
server_script 'server/*.lua'

files { 'weaponcomponents.meta', 'pedpersonality.meta', 'weaponanimations.meta', 'weaponarchetypes.meta', 'weapon_shoe.meta' }
