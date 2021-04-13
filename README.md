#Gold Panning

This is an activity for FiveM servers, it was not created to work for any specific framework and it will be up to you to intergrate this with your server. This resource uses PolyZone's by mkafrin to define pannable rivers, and once a player has started panning in a spot it'll create a "deposit" on his location which can only be used a configured amount of times before it is considered empty. Chances of finding gold vary depending on how many times a deposit has been used.

**Requirements**
https://github.com/mkafrin/PolyZone

**Config**
Make sure you go over the config and set up everything how you would like it.

If you disable pressing "E" (Or whatever keybind it is changed to in the FiveM settings) then you can always use the built in event to start the gold panning process (i.e. if you use a pan item then trigger this event)

Clientside event to trigger
> Client Event: GoldPanning:StartProcess

Events that can be listened on both client and server 
> Client: GoldPanning:Reward (Params: amountOfNuggets)
> Server: GoldPanning:Reward (Params: source, amountOfNuggets)

**Default Config**
```lua
-- Debug mode which visualizes the zones for you and the radius of deposits that have been used by players.
Panning.Config.DebugMode = false

-- Prop that goes into players hand when "sifting"
Panning.Config.PropName = "bkr_prop_coke_metalbowl_02"

-- How much radius each deposit takes up (Can be seen by enabling DebugMode)
Panning.Config.DepositSize = 8.0
-- How many times can each deposit be "used"
Panning.Config.DepositMaxUses = 20
 -- Amount of time it takes to do the panning process (20 seconds default)
Panning.Config.TimeAmount = 20000

Panning.Config.EnableMessages = true -- Enable chat messages
-- Eable the keybind feature
Panning.Config.EnableOnUse = true -- Look for siftable / pannable deposits when E is pressed
```
**Screenshots**
[![Two deposits that have been used](https://i.vgy.me/HV10VE.jpg "Two deposits that have been used")](https://i.vgy.me/HV10VE.jpg "Two deposits that have been used")

[![](https://i.vgy.me/xP8qUg.png)](https://i.vgy.me/xP8qUg.png)
