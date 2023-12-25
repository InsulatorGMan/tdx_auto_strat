--[[
    Tower Defense X Autostrategy - Core_Lobby.lua
    InsulatorGMan
    Version 1.0.1
]] local TDX_AutoStrat_Lobby = {}

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Workspace = game:GetService('Workspace')
local Players = game:GetService('Players')

-- // Move the player's character into the lobby's trigger.
local function JoinLobby(lobbyNumber)
    local Player = Players.LocalPlayer.Character
    Player:PivotTo(Workspace['APCs'][lobbyNumber]['APC'].Detector.CFrame)
end
-- // Looks for the required lobby & automatically joins it when found.
TDX_AutoStrat_Lobby.SearchForGame = function(mapName)
    local Lobbies = Workspace['APCs']:GetChildren()
    for i, lobby in pairs(Lobbies) do
        local LobbyScreen = lobby['mapdisplay']['screen']['displayscreen']
        local Map = LobbyScreen['map'].Text
        if Map == mapName then JoinLobby(lobby.Name) end
    end
end

return TDX_AutoStrat_Lobby
