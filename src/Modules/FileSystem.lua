--[[
    Tower Defense X Autostrategy - Modules/FileSystem.lua
    InsulatorGMan
    Version 1.0.0
]] local FileSystem = {}

FileSystem.folderExists = function(folderPath)
    return isfolder(folderPath)
end

FileSystem.makeFolder = function(folderPath, folderName)
    if not FileSystem.folderExists(folderPath .. folderName) then
        makefolder(folderPath .. folderName)
    end
end

return FileSystem
