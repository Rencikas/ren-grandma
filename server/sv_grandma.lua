local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ren-grandma:revive', function()
    local pData = QBCore.Functions.GetPlayer(source)
    if pData.Functions.RemoveMoney("cash", Shared.GrandmaCost) then
        TriggerClientEvent("hospital:client:Revive", source)
        if Shared.HealInjuries then
            TriggerClientEvent("hospital:client:HealInjuries", source, "full")
        end
    end
end)