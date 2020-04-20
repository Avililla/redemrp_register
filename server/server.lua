data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent('redemrp_register:register')
AddEventHandler('redemrp_register:register',function(otherplayer)
  local _source = source
  local generalInventory = exports.redemrp_inventory:getInventory()
  local otherinventory
  
  TriggerEvent('redemrp:getPlayerFromId', otherplayer, function(other)
    local otheridentifier = other.getIdentifier()
    local othercharid = other.getSessionVar("charid")
    for k,v in pairs(generalInventory) do 
      if v.id == otheridentifier and v.charid == othercharid then
       otherinventory = v.inventory
      end
    end
  end)
    local cuantity = 0
    for k,v in pairs(otherinventory) do
      cuantity = cuantity+v
      data.delItem(otherplayer,k,v) 
      data.addItem(_source,k,v)
    end
    --print(cuantity)
  if cuantity ~= 0 then
    TriggerClientEvent("redemrp_notification:start", otherplayer, 'You are being registered', 5)
    TriggerClientEvent("rdr3_register:animation",_source)
  else
    TriggerClientEvent("rdr3_register:animation",_source)
    Citizen.Wait(5000)
    TriggerClientEvent("redemrp_notification:start",_source, 'The body is empty', 5)
  end
end)
  