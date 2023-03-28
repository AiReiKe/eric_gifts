if Config.oldESX then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterServerEvent('eric_gifts:getgift')
AddEventHandler('eric_gifts:getgift',function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll('SELECT have_gift FROM users WHERE identifier = @identifier', {

        ['@identifier'] = xPlayer.identifier
        
    }, function(result)
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('getting_gift', Config.giftname))
        
        Citizen.Wait(5000)

        if result[1] and result[1].have_gift == 1 then
             TriggerClientEvent('esx:showNotification', xPlayer.source, _U('haved_gift'))
        else
            MySQL.Async.execute('UPDATE users SET have_gift = @have_gift WHERE identifier = @identifier', {

		    	['@identifier'] = xPlayer.identifier,
		    	['@have_gift'] = 1

		    }, function()
            
                if Config.giftpack == true then
                    xPlayer.addInventoryItem('new_gift', 1)
                else
                    TriggerEvent('eric_gifts:getgiftitem', xPlayer.source)
                end
            
                TriggerClientEvent('esx:showNotification', xPlayer.source, _U('got_gift', Config.giftname))
		    end)
        end
    end)
end)

RegisterServerEvent('eric_gifts:getgiftitem')
AddEventHandler('eric_gifts:getgiftitem',function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    for i = 1, #Config.Item, 1 do
        if Config.Item[i].name == 'cash' then
            xPlayer.addMoney(Config.Item[i].count)
        elseif Config.Item[i].name == 'bank' then
            xPlayer.addAccountMoney('bank', Config.Item[i].count)
        elseif Config.Item[i].name == 'car' then
            TriggerClientEvent("eric_gifts:spawnVehicle", source, "car", Config.Item[i].model)
        elseif Config.Item[i].name == 'aircraft' then
            TriggerClientEvent("eric_gifts:spawnVehicle", source, "aircraft", Config.Item[i].model)
        elseif Config.Item[i].name == 'boat' then
            TriggerClientEvent("eric_gifts:spawnVehicle", source, "boat", Config.Item[i].model)
        else
            xPlayer.addInventoryItem(Config.Item[i].name, Config.Item[i].count)
        end
    end
end)

RegisterServerEvent('eric_gifts:setVehicle')
AddEventHandler('eric_gifts:setVehicle', function (vehicleProps, playerID, vehicleType)
	local _source = playerID
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored, type) VALUES (@owner, @plate, @vehicle, @stored, @type)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@stored']  = 1,
		['type'] = vehicleType
	}, function ()
        TriggerClientEvent("eric_gifts:giveCarKey", _source, ESX.Math.Trim(vehicleProps.plate))
		TriggerClientEvent('esx:showNotification', _source, _U('received_car', string.upper(vehicleProps.plate)))
	end)
end)

ESX.RegisterUsableItem('new_gift', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('new_gift', 1)
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('open_gift', Config.giftname))
    TriggerEvent('eric_gifts:getgiftitem', xPlayer.source)
end)



print('Thank you for using eric_gifts, This script made by AiReiKe')
