fx_version 'adamant'

game 'gta5'

description 'Eric Gifts'

client_scripts {
    '@es_extended/locale.lua',
	'locales/tw.lua',
	'config.lua',
	'client.lua'
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/tw.lua',
	'config.lua',
	'server.lua'
}