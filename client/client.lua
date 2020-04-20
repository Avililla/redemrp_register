function text()
  local msg 
  local str
    SetTextScale(0.5, 0.5)
     msg = "Press ~t6~[J]~q~ to register."
     str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
  
end

function getClosestPlayer(coords)
    local players = GetPlayers()
    local closestDistance = 5
    local closestPlayer = {}
    local coords = coords
    local usePlayerPed = false 
    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    if coords == nil then 
        usePlayerPed = true 
        coords = GetEntityCoords(playerPed)
    end

    for i=1, #players,1 do
        local target = GetPlayerPed(players[i])
        
        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then 
            local targetCoords = GetEntityCoords(target)
            local distance = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

            if closestDistance > distance then
                table.insert(closestPlayer, players[i])
                closestDistance = distance
            end
        end
    end
    --print(closestPlayer)
    return closestPlayer, closestDistance
end

function GetPlayers()
  local players = {}
  for k,v in ipairs(GetActivePlayers()) do
    table.insert( players,v)
  end
  return players
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local coords = GetEntityCoords(PlayerPedId()) 
    local closestPlayer = getClosestPlayer()
    for k,v in pairs(closestPlayer) do
      local otherped = GetPlayerPed(v)
      local otherCoords = GetEntityCoords(otherped) 
      if coords then 
        if(IsPedDeadOrDying(otherped) and Vdist(coords.x,coords.y,coords.z,otherCoords.x,otherCoords.y,otherCoords.z)<2.0) then
        text(true)
          if Citizen.InvokeNative(0x580417101DDB492F, 0, 0xF3830D8E) then
            local serverId = GetPlayerServerId(v)
            TriggerServerEvent('redemrp_register:register',serverId)
            exports['progressBars']:startUI(5000, "Registering...")
            Citizen.Wait(5000)  
          end
        end
      end
    end
  end
end)

--This is a copy paste animation of redemrp_inventory i will change it, it was for prooving all and be sure all was working
RegisterNetEvent('rdr3_register:animation')
AddEventHandler('rdr3_register:animation', function(obj)
  local dict = "amb_work@world_human_box_pickup@1@male_a@stand_exit_withprop"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "exit_front", 1.0, 8.0, -1, 1, 0, false, false, false)
	Wait(1200)
	PlaySoundFrontend("CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true, 1)
  	  print("start")
	Wait(1000)
	ClearPedTasks(PlayerPedId())
end)

