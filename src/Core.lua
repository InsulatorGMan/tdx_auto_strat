--[[
    Tower Defense X Autostrategy - Core.lua
    InsulatorGMan
    Version 1.0.0
]] local TDX_AutoStrat = {}

-- // Modules
local Signal = require('Modules/Signal.lua')
local FileSystem = require('Modules/FileSystem.lua')

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Workspace = game:GetService('Workspace')
local Players = game:GetService('Players')

local UI = require('Enum/UI.lua')
local Towers = require('Enum/Towers.lua')

-- // Environment Variables
TDX_AutoStrat.Debug = false
TDX_AutoStrat.WorkSpaceFolder = 'TDX_AutoStrat'
TDX_AutoStrat.StrategyFolder = 'Strategy'

-- // Initializes the workspace folders.
function TDX_AutoStrat:Init()
    FileSystem.makeFolder(TDX_AutoStrat.WorkSpaceFolder)
    FileSystem.makeFolder(TDX_AutoStrat.WorkSpaceFolder .. '/' ..
                              TDX_AutoStrat.StrategyFolder)
end
-- // Move the player's character into the lobby's trigger.
local function JoinLobby(lobbyNumber)
    local Player = Players.LocalPlayer.Character
    Player:PivotTo(Workspace['APCs'][lobbyNumber]['APC'].Detector.CFrame)
end
-- // Looks for the required lobby & automatically joins it when found.
TDX_AutoStrat.SearchForGame = function(mapName)
    local Lobbies = Workspace['APCs']:GetChildren()
    for i, lobby in pairs(Lobbies) do
        local LobbyScreen = lobby['mapdisplay']['screen']['displayscreen']
        local Map = LobbyScreen['map'].Text
        if Map == mapName then JoinLobby(lobby.Name) end
    end
end
--[[
Takes in the required money, and a callback function
is fired when the required money is obtained.
]]
local function WaitForRequiredMoney(money, callback)
    local moneySignal = Signal.new()
    moneySignal:Connect(callback)
    UI.BottomBar.Cash.Changed:Connect(function()
        if UI.BottomBar.Cash.Text:gsub("%s", ""):gsub("$", "") >= money then
            Signal:Fire()
            Signal:Disconnect()
        end
    end)
end

local function WaitForWaveChange(callback)
    local waveChangeSignal = Signal.new()
    waveChangeSignal:Connect(callback)
    UI.GameInfoBar.Wave.Changed:Connect(function() end)
end

-- // Places a tower onto the battlefield.
TDX_AutoStrat.PlaceTower = function(towerName, position)
    WaitForRequiredMoney(Towers[towerName][0],
                         TDX_AutoStrat.RemotesFolder:WaitForChild('PlaceTower')
                             :FireServer(unpack({
            [1] = 0,
            [2] = towerName,
            [3] = position,
            [4] = 0
        })))
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
TDX_AutoStrat.PlayGame = function(commands)
    for i, command in pairs(commands) do end
end
return TDX_AutoStrat
