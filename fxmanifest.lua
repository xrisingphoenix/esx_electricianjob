fx_version 'adamant'
game 'gta5'

script_author 'xrisingphoenix'
description 'Phoenix Studios - Electrician Job'

shared_scripts {
	'config.lua',
	'@ox_lib/init.lua',
}

lua54 'yes'

client_scripts {
	'client.lua',
	'config.lua'
}

server_scripts {
	'server.lua',
}
shared_script '@es_extended/imports.lua'