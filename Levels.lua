--This is the script for levels and things.

local Maps = {}
SampleLevel = { -- size is 25x14
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    ["SpawnTileX"] = 1,
    ["SpawnTileY"] = 1,
    ["Trees"] = {},
    ["Enemies"] = {}
}
Maps.CurrentLevel = {}
Maps.LevelMenu = {}
Maps.Level1 = {
    {2,2,2,2,2,2,2,2,1,1,3,2,2,2,2,2,2,2,2,2,2,1,1,2,1},
    {2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {1,2,1,2,2,2,2,1,2,2,2,2,2,2,2,2,2,1,2,1,2,1,2,2,1},
    {1,2,2,1,2,1,1,1,1,2,2,2,2,2,1,2,2,2,2,2,1,2,1,2,2},
    {2,2,1,2,1,2,2,2,2,2,2,2,2,1,2,1,2,1,2,2,2,2,1,2,1},
    {1,1,2,1,2,1,2,2,2,2,2,1,2,1,2,2,2,2,2,2,1,2,2,2,2},
    {2,2,1,2,1,2,1,1,1,1,2,1,2,1,2,2,2,2,1,1,2,2,2,2,2},
    {1,2,2,1,2,1,2,2,2,2,2,1,2,1,2,2,2,2,1,2,1,2,2,2,2},
    {1,2,1,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,2,2,2,2,2},
    {2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,2,2,2,2,2},
    {2,2,1,2,2,2,2,2,1,1,2,2,1,1,2,2,1,1,1,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,1,2,1,1,2,1,2,2,2,1,2,1,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,1,2,2,1,2,1,2,1,2,1,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    ["SpawnTileX"] = 10,
    ["SpawnTileY"] = 14,
    ["Trees"] = {{18,11},{14,6},{12,6},{7,4}},
    ["Enemies"] = {}
}
Maps.Level2 = {
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,2,1,2,2,2,2,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2},
    {2,2,2,1,1,1,1,2,1,2,1,2,2,1,2,1,4,2,2,2,2,2,2,2,2},
    {2,2,2,2,1,2,1,2,2,2,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2},
    {4,2,1,2,1,1,1,2,1,2,1,2,1,2,1,1,2,2,2,2,2,2,2,2,2},
    ["SpawnTileX"] = 1,
    ["SpawnTileY"] = 14,
    ["Trees"] = {},
    ["Enemies"] = {{10,7,3,1},{15,9,1,2}}
}
function Maps.LoadLevel(Level)
    for i,v in pairs(Maps.CurrentLevel) do
            table.remove(CurrentLevel,1)
        end
        for i,v in pairs(Maps["Level"..Level]) do
            table.insert(Maps.CurrentLevel,v)
         print("Loaded row "..i.." in level "..Level)
     end
end

return Maps