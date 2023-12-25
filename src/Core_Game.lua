--[[
    Tower Defense X Autostrategy - Core_Game.lua
    InsulatorGMan
    Version 1.0.1
]] local TDX_AutoStrat = {}

-- // Modules
local BaseGetURL =
    "https://raw.githubusercontent.com/InsulatorGMan/tdx_auto_strat/main/src/"

local ReplicatedStorage = game:GetService('ReplicatedStorage')

local UI = loadstring(game.HttpService:GetAsync(BaseGetURL .. 'Enum/UI.lua'))()
local Towers = loadstring(game.HttpService:GetAsync(BaseGetURL ..
                                                        'Enum/Towers.lua'))()

-- // Environment Variables
TDX_AutoStrat.Debug = false
TDX_AutoStrat.WorkSpaceFolder = 'TDX_AutoStrat'
TDX_AutoStrat.StrategyFolder = 'Strategy'
TDX_AutoStrat.RemotesFolder = ReplicatedStorage:WaitForChild('Remotes')

--[[
Takes in the required money, and a callback function
is fired when the required money is obtained.
]]
local function WaitForRequiredMoney(money, callback)

    local cleanedAmount = UI.BottomBar.Cash.Text:gsub("[%s$]", "")
    local currentAmount = tonumber(cleanedAmount)

    repeat wait() until currentAmount and currentAmount >= money
    print(cleanedAmount)
    print(currentAmount)
    if currentAmount and currentAmount >= money then callback() end
end

TDX_AutoStrat.WaitForWaveChange = function(callback)
    UI.GameInfoBar.Wave.Changed:Connect(function() callback() end)
end

-- // Places a tower onto the battlefield.
TDX_AutoStrat.PlaceTower = function(towerName, position)
    WaitForRequiredMoney(Towers[towerName][0], function()
        TDX_AutoStrat.RemotesFolder:WaitForChild('PlaceTower'):InvokeServer(
            unpack({[1] = 0, [2] = towerName, [3] = position, [4] = 0}))
    end)
end
-- // Upgrades the tower provided.
TDX_AutoStrat.UpgradeTower = function(towerName, towerId, path)
    WaitForRequiredMoney(Towers[towerName][0],
                         TDX_AutoStrat.RemotesFolder:WaitForChild(
                             'TowerUpgradeRequest'):FireServer(unpack({
        [1] = towerId,
        [2] = path
    })))
end
-- // Sells the provided tower.
TDX_AutoStrat.SellTower = function(towerId)
    TDX_AutoStrat.RemotesFolder:WaitForChild('SellTower'):FireServer(unpack({
        [1] = towerId
    }))
end
-- // Use tower's ability
TDX_AutoStrat.UseTowerAbility = function(towerId)
    TDX_AutoStrat.RemotesFolder:WaitForChild("TowerUseAbilityRequest")
        :InvokeServer(unpack({[1] = towerId, [2] = 1}))
end
-- // Change the provided tower's targeting
TDX_AutoStrat.ChangeTowerTargeting = function(towerId, newTargeting)
    TDX_AutoStrat.RemotesFolder:WaitForChild("ChangeQueryType"):FireServer(
        unpack({
            [1] = towerId,
            [2] = newTargeting -- [0] - First, [1] - Last, [2] - Strongest, [3] - Weakest, [4] - Random
        }))
end
-- // Cast vote to skip the current wave.
TDX_AutoStrat.SkipWave = function()
    TDX_AutoStrat.RemotesFolder:WaitForChild("SkipWaveVoteCast"):FireServer(
        unpack({[1] = true}))
end
-- // Cast difficulty vote
TDX_AutoStrat.VoteForDifficulty = function(difficulty)
    TDX_AutoStrat.RemotesFolder:WaitForChild("DifficultyVoteCast"):FireServer(
        unpack({[1] = difficulty}))
end
-- // Ready up after voting for a difficulty
TDX_AutoStrat.Ready = function()
    TDX_AutoStrat.RemotesFolder:WaitForChild("DifficultyVoteReady"):FireServer()
end
-- // Takes in a boolean, enables & disables the 50% speed boost gamepass
TDX_AutoStrat.SpeedBoost = function(state)
    TDX_AutoStrat.RemotesFolder:WaitForChild("ToggleSpeedupTier1"):FireServer(
        unpack({[1] = state}))
end

-- // Core game player.
TDX_AutoStrat.PlayGame = function(commandWaves)
    for i, commandWave in pairs(commandWaves) do
        commandWaves[i]()
        print(commandWaves[i])
        TDX_AutoStrat.WaitForWaveChange(function()
            print('Command Wave: ' .. i .. ' done.')
        end)
    end
end
return TDX_AutoStrat
