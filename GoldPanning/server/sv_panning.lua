function Panning.CheckDeposit(coords)
  local depFound = nil
  for k, v in pairs(Panning.Zones.PlayerDeposits) do
    if (#(v.pos-coords) < Panning.Config.DepositSize) then
      depFound = v
    end
  end

  return depFound
end

function Panning.Message(text, source)
  if (not Panning.Config.EnableMessages) then return end
  TriggerClientEvent('chat:addMessage', source, {color = {200, 200, 200}, args = {"ACTIVITY", text}})
end

function Panning.CheckReward(source, uses)
  if (uses >= Panning.Config.DepositMaxUses) then
    Panning.Message("This deposit looks like it has been messed with too much..", source)
    TriggerClientEvent("GoldPanning:Finished", source)
    return
  end

  math.randomseed(os.time())
  
  local chance = math.random(0,100)

  -- Chance to find anything.
  if (chance > (40+uses)) then
    -- TODO: Make this more configurable.
    local nuggetPerc = (1.1 + (uses/100)) * math.random(1,15)
    local nuggetChance = math.floor(math.random(5,100)/nuggetPerc)

    Panning.Debug("%: ", nuggetPerc)
    Panning.Debug("Chance Finished: ", nuggetChance)

    if nuggetChance < 2 then
      nuggetChance = 2
    end

    -- Give nuggets
    Panning.Message("You received " .. nuggetChance .. " gold nuggets!", source)
    TriggerClientEvent("GoldPanning:Finished", source)
  else
    Panning.Message("You found nothing but dirt.", source)
    TriggerClientEvent("GoldPanning:Finished", source)
  end
end

RegisterNetEvent("GoldPanning:CheckPosition")
AddEventHandler("GoldPanning:CheckPosition", function(playerCoords)
  local _source = source
  local deposit = Panning.CheckDeposit(playerCoords)

  if (deposit ~= nil) then
    Panning.Debug("Found a deposit that existed here with " .. deposit.uses .. " uses")
    Panning.CheckReward(_source, deposit.uses)

    deposit.uses = deposit.uses + 1
  else
    local tmp = {
      pos = playerCoords,
      originalCreator = _source,
      uses = 0 -- How many times has this place been used
    }

    table.insert(Panning.Zones.PlayerDeposits, tmp)

    Panning.Debug("User found a new deposit, creating a table.")

    Panning.CheckReward(_source, 0)
  end

  if (Panning.Config.DebugMode) then
    TriggerClientEvent("GoldPanning:UpdateDeposits", -1, Panning.Zones.PlayerDeposits)
  end
end)