RegisterServerEvent('getData')
AddEventHandler('getData', function()
    local player = source
    local license = xPlayer.GetPlayerIdentifierFromType("steam", player)
    

    local name = ""
    local job = ""
    local cash = ""
    local bank = ""
    local model = ""
    local heat = ""
    local weed = ""
    local coke = ""
    local meth = ""   
   
    exports.oxmysql:query("SELECT name, job, cash, bank, model, heat, weed, coke, meth FROM player_data WHERE license = ?", {license}, function(result)
        if result then
            if not result[1] then
                exports.oxmysql:query("INSERT INTO player_data (license, name, job, cash, bank, model, heat, weed, coke, meth) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", {license, GetPlayerName(player) , "Dealer", Server.Config.NewPlayerCash, Server.Config.NewPlayerBank, "g_m_y_famca_01",0,100,20,10})
                                
                name = result[1].name
                job = result[1].job
                cash = result[1].cash
                bank = result[1].bank 
                model = result[1].model
                heat = result[1].heat
                weed = result[1].weed
                coke = result[1].coke
                meth = result[1].meth
                 
                xPlayer.Data[player] = {["name"] = name, ["job"] = job , ["cash"] = cash, ["bank"] = bank, ["model"] = model, ["heat"] = heat, ["weed"] = weed, ["coke"] = coke, ["meth"] = meth}
                Citizen.Wait(500)
            end
            
            xPlayer.Currency.Update(player)
            --TriggerClientEvent('updateData', player, name, job, cash, bank, model, heat, weed, coke, meth)
        end
    end)
end)

RegisterServerEvent('updateModel')
AddEventHandler('updateModel', function(model)
    player = source    
    xPlayer.Functions.SaveModel(model,player)
end)

