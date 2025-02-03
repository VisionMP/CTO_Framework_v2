xPlayer = {}
xPlayer.Currency = {}
xPlayer.Functions = {}
xPlayer.Data = {}

function getDataObject()
    return xPlayer
end

xPlayer.GetPlayerIdentifierFromType = function(type, source)
    local identifierCount = GetNumPlayerIdentifiers(source)
    for count = 0, identifierCount do
        local identifier = GetPlayerIdentifier(source, count)
        if identifier and string.find(identifier, type) then
            return identifier
        end
    end
    return nil
end

xPlayer.Currency.Update = function(player)
    local player = tonumber(player)
    local license = xPlayer.GetPlayerIdentifierFromType("steam", player)
    
    Citizen.Wait(500)
    exports.oxmysql:query("SELECT name, job, cash, bank, model, heat, weed, coke, meth FROM player_data WHERE license = ?", {license}, function(result)
          if result then           
            name = result[1].name
            job = result[1].job
            cash = result[1].cash
            bank = result[1].bank 
            model = result[1].model
            heat = result[1].heat
            weed = result[1].weed
            coke = result[1].coke
            meth = result[1].meth

            xPlayer.Data[player] = {["name"] = name, ["job"] = job ,["cash"] = cash, ["bank"] = bank, ["model"] = model, ["heat"] = heat, ["weed"] = weed, ["coke"] = coke, ["meth"] = meth}
            
            Citizen.Wait(500)

            --xPlayer.Functions.SaveModel(model,player)
            TriggerClientEvent('updateData', player, name, job, cash, bank, model, heat, weed, coke, meth)   
        end
    end)
end

xPlayer.Functions.SaveModel = function(model,player)    
    exports.oxmysql:query("UPDATE player_data SET model = ? WHERE license = ?", {model, xPlayer.GetPlayerIdentifierFromType("steam", player)})
end

xPlayer.Currency.Add = function(amount, player, to)
    local amount = tonumber(amount)
    local player = tonumber(player)
    if to == "bank" then
        exports.oxmysql:query("UPDATE player_data SET bank = bank + ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)       
    elseif to == "cash" then
        exports.oxmysql:query("UPDATE player_data SET cash = cash + ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)           
    elseif to == "heat" then
        exports.oxmysql:query("UPDATE player_data SET heat = heat + ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500) 
    elseif to == "weed" then
        exports.oxmysql:query("UPDATE player_data SET weed = weed + ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500) 
    elseif to == "coke" then
        exports.oxmysql:query("UPDATE player_data SET coke = coke + ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)
    elseif to == "meth" then
        exports.oxmysql:query("UPDATE player_data SET meth = meth + ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)     
    end
    xPlayer.Currency.Update(player)    
end

xPlayer.Currency.Remove = function(amount, player, from)
    local amount = tonumber(amount)
    local player = tonumber(player)
    if from == "bank" then
        exports.oxmysql:query("UPDATE player_data SET bank = bank - ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)        
    elseif from == "cash" then
        exports.oxmysql:query("UPDATE player_data SET cash = cash - ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)             
    elseif to == "heat" then
        exports.oxmysql:query("UPDATE player_data SET heat = heat - ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500) 
    elseif to == "weed" then
        exports.oxmysql:query("UPDATE player_data SET weed = weed - ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500) 
    elseif to == "coke" then
        exports.oxmysql:query("UPDATE player_data SET coke = coke - ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)
    elseif to == "meth" then
        exports.oxmysql:query("UPDATE player_data SET meth = meth - ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)    
    end
    xPlayer.Currency.Update(player)
end

xPlayer.Currency.Withdraw = function(amount, player)
    local amount = tonumber(amount)
    local player = tonumber(player)
    if xPlayer.Data[player].bank >= amount then
        exports.oxmysql:query("UPDATE player_data SET bank = bank - ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        exports.oxmysql:query("UPDATE player_data SET cash = cash + ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)
        xPlayer.functions.update(player)
        return true
    end
    return false
end

xPlayer.Currency.Deposit = function(amount, player)
    local amount = tonumber(amount)
    local player = tonumber(player)
    if xPlayer.Data[player].cash >= amount then
        exports.oxmysql:query("UPDATE player_data SET cash = cash - ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        exports.oxmysql:query("UPDATE player_data SET bank = bank + ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("steam", player)})
        Citizen.Wait(500)
        xPlayer.Currency.Update(player)
        return true
    end
    return false
end

xPlayer.Currency.TransferBank = function(amount, player, target)
    local amount = tonumber(amount)
    local player = tonumber(player)
    local target = tonumber(target)
    if player == target then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You can't send money to yourself."}
        })
        return false
    elseif GetPlayerPing(target) == 0 then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "That player does not exist."}
        })
        return false
    elseif amount <= 0 then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You can't send that amount."}
        })
        return false
    elseif xPlayer.Data[player].bank < amount then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You don't have enough money."}
        })
        return false
    else
        MySQL.query.await("UPDATE player_data SET bank = bank - ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("license", player)})
        xPlayer.Currency.Update(player)
        MySQL.query.await("UPDATE player_data SET bank = bank + ? WHERE license = ?", {amount, xPlayer.GetPlayerIdentifierFromType("license", target)})
        xPlayer.Currency.Update(target)
        TriggerClientEvent("chat:addMessage", player, {
            color = {0, 255, 0},
            args = {"Success", "You paid " .. GetPlayerName(target) .. " $" .. amount .. "."}
        })
        TriggerClientEvent("chat:addMessage", targetId, {
            color = {0, 255, 0},
            args = {"Success", GetPlayerName(player) .. " sent you $" .. amount .. "."}
        })
        return true
    end
end

xPlayer.Functions.DiscordSendMsg = function(name, message)    
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest('https://discord.com/api/webhooks/1331317019374780456/rojJClbugM-vZoINFiY6snLkwLnLi25l7wEel8H0RPwIk6TXzQBFvN9_GtjeZUlGC0fx', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end
