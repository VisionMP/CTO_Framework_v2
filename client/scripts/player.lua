Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetPlayerHealthRechargeLimit(PlayerId(),0.0)
    end
 end)

 RegisterCommand("UpdatePed", function(source,args)
 SetModel(args[1])
 TriggerServerEvent('updateModel',args[1])   
 end, false)