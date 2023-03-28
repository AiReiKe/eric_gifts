local getting_gift = false
local loadingModel = false

if Config.oldESX then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

local function ShowFloatingHelpNotification(msg, coords)
    AddTextEntry('DUTYSTRING', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('DUTYSTRING')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

RegisterNetEvent('eric_gifts:spawnVehicle')
AddEventHandler('eric_gifts:spawnVehicle', function(vehicleType, model)
	while loadingModel do
		Citizen.Wait(1000)
	end
	loadingModel = true
	local orgModelName = model
	model = type(model) == 'string' and GetHashKey(model) or model

	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsModelInCdimage(model) then
		ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info
			while not DoesEntityExist(vehicle) do
				Wait(10)
			end
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local newPlate     = exports.esx_vehicleshop:GeneratePlate()
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			TriggerServerEvent('eric_gifts:setVehicle', vehicleProps, GetPlayerServerId(PlayerId()), vehicleType)
			ESX.Game.DeleteVehicle(vehicle)
		end)
	else
		ESX.ShowNotification(_U('unknown_car', orgModelName))
	end
	
	loadingModel = false
end)

if not Config.GiftPed then
	AddEventHandler("onResourceStop", function(resource)
		if resource == GetCurrentResourceName() then
			TriggerEvent('chat:removeSuggestion', '/'..Config.command)
		end
	end)

	RegisterCommand(Config.command, function()
		if getting_gift == false then
			getting_gift = true
			
			TriggerServerEvent('eric_gifts:getgift')
			print("\nCreate by AiReiKe\nThanks for using\n")
	
			Citizen.Wait(5000)
	
			getting_gift = false
		end
	end)

	Citizen.CreateThread(function()
		TriggerEvent('chat:addSuggestion', '/'..Config.command, _U('get_gift', Config.giftname), {})	
	end)
else
	Citizen.CreateThread(function()
		while true do
			local distance = Vdist(GetEntityCoords(PlayerPedId()), Config.GiftPed.pos.xyz)
			if distance <= 80 then
				if not Config.GiftPed.ped or not DoesEntityExist(Config.GiftPed.ped) then
					Config.GiftPed.model = type(Config.GiftPed.model) == 'string' and GetHashKey(Config.GiftPed.model) or Config.GiftPed.model
					if IsModelInCdimage(Config.GiftPed.model) then
						RequestModel(Config.GiftPed.model)

						while not HasModelLoaded(Config.GiftPed.model) do
							Wait(0)
						end

						Config.GiftPed.ped = CreatePed(0, Config.GiftPed.model, Config.GiftPed.pos.xyz, Config.GiftPed.pos.w, false, true)
            
                        SetPedFleeAttributes(Config.GiftPed.ped, 2)
                        SetBlockingOfNonTemporaryEvents(Config.GiftPed.ped, true)
                        SetPedCanRagdollFromPlayerImpact(Config.GiftPed.ped, false)
                        SetPedDiesWhenInjured(Config.GiftPed.ped, false)
                        FreezeEntityPosition(Config.GiftPed.ped, true)
                        SetEntityInvincible(Config.GiftPed.ped, true)
                        SetPedCanPlayAmbientAnims(Config.GiftPed.ped, false)
						SetModelAsNoLongerNeeded(Config.GiftPed.model)
					end
				end
				if distance <= 8.0 then
					ShowFloatingHelpNotification(_U("press_to_get"), Config.GiftPed.pos.z + 1)
					if IsControlJustReleased(0, 38) and not getting_gift and distance <= 1.5 then
						getting_gift = true
							
						TriggerServerEvent('eric_gifts:getgift')
						print("\nCreate by AiReiKe\nThanks for using\n")
				
						Citizen.Wait(5000)
				
						getting_gift = false
					end
				else
					Citizen.Wait(600)
				end
			else
				if Config.GiftPed.ped then
					FreezeEntityPosition(Config.GiftPed.ped, false)
					DeleteEntity(Config.GiftPed.ped)
					if not DoesEntityExist() then
						Config.GiftPed.ped = nil
					end
				end
				Citizen.Wait(600)
			end
			Citizen.Wait(0)
		end
	end)

	if Config.Blip then
		local blip = AddBlipForCoord(Config.GiftPed.pos.xyz)
		SetBlipSprite(blip, Config.Blip.type or 587)
		SetBlipScale(blip, Config.Blip.scale or 0.8)
        SetBlipColour(blip, Config.Blip.colour or 0)
		SetBlipDisplay(blip, 4)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U("blip_name"))
		EndTextCommandSetBlipName(blip)
	end
end
