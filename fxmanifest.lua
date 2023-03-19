fx_version 'cerulean'

game 'gta5'
version "3.0.0"

description 'Eric Gifts'

shared_scripts {
	'@es_extended/imports.lua',
    '@es_extended/locale.lua',
	'locales/*.lua',
}

client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/*.lua'
}

dependencies {
	'esx_vehicleshop'
}