# TDX Auto Strategy

> ⚠ For educational use only ⚠

## Contribution Guide

1. Clone the latest `main` branch.
2. Make your changes
3. Open a Pull Request

## Testing

### Game

```lua
local TDX = loadstring(game.HttpService:GetAsync(
                           'https://raw.githubusercontent.com/InsulatorGMan/tdx_auto_strat/main/src/Core_Game.lua'))()
TDX.PlayGame({
     function()
        TDX.VoteForDifficulty('Easy')
        TDX.Ready()
        TDX.SpeedBoost()
    end, function()
        TDX.PlaceTower('Shotgunner', Vector3.new(-180.39552307128906,
                                                 -9.067782402038574,
                                                 -657.1604616257812))
        TDX.PlaceTower('Shotgunner', Vector3.new(-183.35752868652344,
                                                 -9.067782402038574,
                                                 -658.4767456054688))
        TDX.UpgradeTower('Shotgunner', 2, 1)
    end, function() TDX.UpgradeTower('Shotgunner', 2, 2) end
})

```
