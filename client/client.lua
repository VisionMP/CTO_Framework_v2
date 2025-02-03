local name = ""
local job = ""
local cash = ""
local bank = ""
local model = ""
local heat = ""
local weed = ""
local coke = ""
local meth = ""   

-- For Exporting --
function getData()
    return {["name"] = name, ["job"] = job, ["cash"] = cash, ["bank"] = bank, ["model"] = model, ["heat"] = heat, ["weed"] = weed, ["coke"] = coke, ["meth"] = meth}
end

-- Update Money on Clientside --
RegisterNetEvent('updateData')
AddEventHandler('updateData', function(_name, _job, _cash, _bank, _model, _heat, _weed, _coke, _meth)
   name, job, cash, bank, model, heat, weed, coke, meth = _name, _job, _cash, _bank, _model, _heat, _weed, _coke, _meth
end)

-- When spawn player ped --
AddEventHandler('playerSpawned', function()       
   TriggerServerEvent('getData')
   Citizen.Wait(2000)  
   SetModel(model)
end)

function SetModel(_model)
   local model = _model
 if IsModelInCdimage(model) and IsModelValid(model) then
   RequestModel(model)
   while not HasModelLoaded(model) do
     Wait(0)
   end
   SetPlayerModel(PlayerId(), model)
   SetModelAsNoLongerNeeded(model)
 end
end

-- Text for HUD --
function text(text, x, y, scale)
   SetTextFont(7)
   SetTextProportional(0)
   SetTextScale(scale, scale)
   SetTextEdge(1, 0, 0, 0, 255)
   SetTextDropShadow(0, 0, 0, 0,255)
   SetTextOutline()
   SetTextJustification(1)
   SetTextEntry("STRING")
   AddTextComponentString(text)
   DrawText(x, y)
end

-- Text Based HUD Display--
Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0)
       text("CASH", 0.885, 0.035, 0.35)
       text("BANK", 0.885, 0.075, 0.35) 
       text("~y~JOB~w~", 0.885, 0.115, 0.35)       
       --text("~y~JOB", 0.885, 0.115, 0.35)               
       text("~g~$~w~ ".. cash, 0.91, 0.03, 0.50)
       text("~b~$~w~ ".. bank, 0.91, 0.07, 0.50)
       text(" ".. job, 0.91, 0.11, 0.50)
       --text("  ".. job, 0.91, 0.109, 0.50)      
       if IsPauseMenuActive() then
           BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
           ScaleformMovieMethodAddParamPlayerNameString(GetPlayerName(PlayerId()))
           PushScaleformMovieFunctionParameterString("Cash: $" .. cash)
           PushScaleformMovieFunctionParameterString("Bank: $" .. bank)
           EndScaleformMovieMethod()
       end
   end
end)