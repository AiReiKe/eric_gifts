ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand(Config.command, function()
    TriggerServerEvent('eric_gifts:getgift')
end)