local QBCore = exports['qb-core']:GetCoreObject()

function CreateGrandma()
    for k,v in pairs(Shared) do
        local poly = Shared.location[k]
        exports['qb-target']:AddBoxZone('ren-grandma:add:BoxZone'..k, poly.coords, poly.length, poly.width, {
                name = 'ren-grandma:add:BoxZone'..k,
                heading = poly.heading,
                debugPoly = false,
                minZ = poly.minZ,
                maxZ = poly.maxZ,
                }, {
                    options = {
                    {
                    event = 'ren-grandma:request:help',
                    icon = 'fas fa-user-injured',
                    label = 'Request help from grandma - '..Shared.GrandmaCost..'$',
                },
            },
            distance = 3.0
        })
    end
end

RegisterNetEvent("ren-grandma:request:help", function()
	if QBCore.Functions.GetPlayerData().money['cash'] >= Shared.GrandmaCost then  
        QBCore.Functions.Progressbar('name_here', 'Grandma is healing you..', 5000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
        end, function()
            TriggerServerEvent("ren-grandma:revive")
        end)
    else
        QBCore.Functions.Notify("Grandma won't help, if you don't have some cash for her", "error", 5000)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateGrandma()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        CreateGrandma()
    end
end)