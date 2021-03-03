local getting_gift = false
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
