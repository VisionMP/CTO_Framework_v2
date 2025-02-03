xPlayer = {}

xPlayer.GetRandomItem = function()
    return Config.Items[math.random(#Config.Items)]
  end

---@param num1 number
---@param num2 number  
xPlayer.GetRandomNumber = function(num1,num2)
      return math.random(num1,num2)
end

