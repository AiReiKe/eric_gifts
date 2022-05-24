local getting_gift = false
local loadingModel = false
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand(Config.command, function()
    if getting_gift == false then
        getting_gift = true
        
        TriggerServerEvent('eric_gifts:getgift')
        print("\nCreate by AiReiKe\nThanks for using\n")

        Citizen.Wait(5000)

        getting_gift = false
    end
end)

RegisterNetEvent('eric_gifts:spawnVehicle')
AddEventHandler('eric_gifts:spawnVehicle', function(vehicleType, model)
	while loadingModel do
		Citizen.Wait(1000)
	end
		
	loadingModel = true
		
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local carExist  = false

	ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			carExist = true
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local newPlate     = exports.esx_vehicleshop:GeneratePlate()
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			TriggerServerEvent('eric_gifts:setVehicle', vehicleProps, GetPlayerServerId(PlayerId()), vehicleType)
			ESX.Game.DeleteVehicle(vehicle)	
		end		
	end)
	
	Wait(2000)
	if not carExist then
		ESX.ShowNotification(_U('unknown_car', model))		
	end
	
	loadingModel = false
end)

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/'..Config.command, _U('get_gift', Config.giftname), {})	
end)
