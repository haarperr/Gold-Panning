local inZone = false
local panProp = nil
local isPanning = false

function Panning.CanPan()
  return (not IsPedSwimmingUnderWater(PlayerPedId()) and inZone and IsEntityInWater(PlayerPedId()) and not IsPedSwimming(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) and not isPanning)
end

function Panning.HasRequiredItems()
  return true
end

Citizen.CreateThread(function()
  for zoneName, zoneObj in pairs(Panning.Zones) do
    zoneObj:onPointInOut(PolyZone.getPlayerPosition, function(isInside, point)
      inZone = isInside
      Panning.Debug("[PZ]" .. (isInside and "Inside" or "Outside") .. " " .. zoneName)
    end)
  end
end)

function Panning.Message(text)
  if (not Panning.Config.EnableMessages) then return end
  TriggerEvent('chat:addMessage', {color = {200, 200, 200}, args = {"ACTIVITY", text}})
end

function Panning.AttachPanItem()
  local panModel = GetHashKey(Panning.Config.PropName)
	local bone = GetPedBoneIndex(PlayerPedId(), 28422)

	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)

	RequestModel(panModel)
	while (not HasModelLoaded(panModel)) do
		Citizen.Wait(100)
	end

	panProp = CreateObject(panModel, 1.0, 1.0, 1.0, 1, 1, 0)
	SetModelAsNoLongerNeeded(panModel)
	AttachEntityToEntity(panProp, PlayerPedId(), bone, 0.062, 0.02, 0.0, 0, 0, 0, 1, 1, 0, 1, 2, 1)
end

function Panning.StopProcess()
  if (DoesEntityExist(panProp)) then
    DeleteEntity(panProp)
  end

  ClearPedTasks(PlayerPedId())
end

function Panning.StartProcess()
  isPanning = true
  local animDict = "rcmextreme3"

  RequestAnimDict(animDict)

  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(0)
  end

  if IsEntityPlayingAnim(PlayerPedId(), animDict, "idle", 3) then
    ClearPedSecondaryTask(PlayerPedId())
  else
    Panning.AttachPanItem()
    TaskPlayAnim(PlayerPedId(), animDict, "idle", 0.7, 0.7, 1.0, 1, -1, 0, 0, 0)

    Citizen.Wait(math.random(1000,2000))

    Panning.Message("Soaking pan with water..")

    -- Insert progress bar here.
    Citizen.Wait(Panning.Config.TimeAmount)

    local playerCoords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("GoldPanning:CheckPosition", playerCoords)
  end
end

RegisterNetEvent("GoldPanning:Finished")
AddEventHandler("GoldPanning:Finished", function()
  isPanning = false
  Panning.StopProcess()
end)

-- Changed into an event in-case someone wants to change to a useable item.
AddEventHandler("GoldPanning:StartProcess", function()
  if (Panning.CanPan()) then
    if (Panning.HasRequiredItems()) then
      Panning.Debug("Start Panning")
      Panning.Message("You start scooping deposits into your pan.")
      Panning.StartProcess()
    end
  else
    Panning.Message("This is not a suitable place for deposits.")
  end
end)

if (Panning.Config.EnableOnUse) then
  RegisterCommand('+startPanning', function()
    TriggerEvent("GoldPanning:StartProcess")
  end, false)

  RegisterCommand('-startPanning', function() end, false)
  RegisterKeyMapping('+startPanning', 'Gold Panning', 'keyboard', 'E')
end
-- Dev shit

RegisterNetEvent("GoldPanning:UpdateDeposits")
AddEventHandler("GoldPanning:UpdateDeposits", function(data)
  Panning.Zones.PlayerDeposits = data
end)

if Panning.Config.DebugMode then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      for k, v in pairs(Panning.Zones.PlayerDeposits and Panning.Zones.PlayerDeposits or {}) do
        DrawMarker(1, v.pos.x, v.pos.y, v.pos.z - 2.0, 0,0,0,0,0,0, Panning.Config.DepositSize, Panning.Config.DepositSize, 15.0, 255, 100, 100, 100, 0, 0, 0, 0)
      end
    end
  end)
end