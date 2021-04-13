Panning = {}
Panning.Config = {}
Panning.Config.DebugMode = false -- Keep in mind that debug mode slows down the resource significantly

Panning.Config.PropName = "bkr_prop_coke_metalbowl_02" -- Prop that goes into players hand when "sifting"
Panning.Config.DepositSize = 8.0 -- Radius for each deposit that a player searches
Panning.Config.DepositMaxUses = 20 -- How many times can each deposit be "used"
Panning.Config.TimeAmount = 20000 -- Takes 20 seconds to finish panning.

Panning.Config.EnableMessages = true -- Enable chat messages
Panning.Config.EnableOnUse = true -- Look for siftable / pannable deposits when E is pressed

Panning.Zones = {}
Panning.Zones.PlayerDeposits = {}

if (not IsDuplicityVersion()) then
    Panning.Zones = {}
    Panning.Zones["ZancudoRiver"] = PolyZone:Create({
        vector2(135.32255554199, 3336.1887207031),
        vector2(99.258346557617, 3353.5910644531),
        vector2(-614.35107421875, 3024.8022460938),
        vector2(-1144.4312744141, 2854.978515625),
        vector2(-1448.9338378906, 2707.2592773438),
        vector2(-1319.7143554688, 2592.8076171875),
        vector2(-869.09014892578, 2757.6809082031),
        vector2(-580.57067871094, 2878.1906738281),
        vector2(-504.02600097656, 2853.3383789062),
        vector2(-224.55001831055, 2957.0617675781),
        vector2(21.208827972412, 3079.0986328125),
        vector2(84.656593322754, 3147.2778320312)
    }, {name="ZancudoRiver", debugGrid=Panning.Config.DebugMode})

    Panning.Zones["TongvaValley"] = PolyZone:Create({
        vector2(-1511.525390625, 1527.9259033203),
        vector2(-1487.9442138672, 1552.4429931641),
        vector2(-1512.7355957031, 1647.7341308594),
        vector2(-1518.6496582031, 1700.1247558594),
        vector2(-1513.9753417969, 1728.8693847656),
        vector2(-1447.1978759766, 1869.8087158203),
        vector2(-1415.5291748047, 1998.4932861328),
        vector2(-1380.7731933594, 2181.6896972656),
        vector2(-1482.8404541016, 2462.3979492188),
        vector2(-1550.8513183594, 2456.6884765625),
        vector2(-1525.4765625, 2243.2160644531),
        vector2(-1717.9243164062, 2081.0014648438)
    }, {name="TongvaValley", debugGrid=Panning.Config.DebugMode})

    Panning.Zones["CassidyCreek"] =  PolyZone:Create({
        vector2(-548.36175537109, 4414.0727539062),
        vector2(-580.86853027344, 4461.4135742188),
        vector2(-683.47430419922, 4466.1694335938),
        vector2(-761.14416503906, 4465.6655273438),
        vector2(-829.6845703125, 4463.80859375),
        vector2(-947.04949951172, 4415.9575195312),
        vector2(-1089.7738037109, 4414.1826171875),
        vector2(-1225.3631591797, 4421.4853515625),
        vector2(-1363.8637695312, 4370.9814453125),
        vector2(-1454.8546142578, 4375.083984375),
        vector2(-1598.4825439453, 4455.7524414062),
        vector2(-1650.4764404297, 4505.1928710938),
        vector2(-1752.9047851562, 4570.4829101562),
        vector2(-1854.3348388672, 4493.5249023438),
        vector2(-1656.4415283203, 4379.3149414062),
        vector2(-1502.7706298828, 4295.5356445312),
        vector2(-1386.1896972656, 4300.3002929688),
        vector2(-974.24865722656, 4337.3720703125),
        vector2(-593.71221923828, 4395.1762695312)
    }, {name="CassidyCreek", debugGrid=Panning.Config.DebugMode})
end

function Panning.Debug(...)
    if (not Panning.Config.DebugMode) then return end

    print(...)
end