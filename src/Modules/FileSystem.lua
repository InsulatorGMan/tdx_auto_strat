--[[
    Tower Defense X Autostrategy - Modules/FileSystem.lua
    InsulatorGMan
    Version 1.0.0
]] local FileSystem = {}

-- // Checks if a folder exists.
FileSystem.folderExists = function(folderPath) return isfolder(folderPath) end
-- // Checks if the folder exists. If it does not, create it.
FileSystem.makeFolder = function(folderPath, folderName)
    if not FileSystem.folderExists(folderPath .. folderName) then
        makefolder(folderPath .. folderName)
    end
end

return FileSystem
