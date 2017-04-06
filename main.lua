-- Made by fixylol
--[[
Ideas:
Pushable trees [DONE]
"Bad guys" (behave like the enemies in bad guys.sim) [DONE]
Ice (behaves like the ice in that club penguin game) [DONE]
Multiple levels
Reset the timer when the level ends/you lose [DONE]
 ]]
--Currently in progress: Multiple Levels
timer = 0
gtimer = 0
debug = true
debounce = 0
chartilex = 1
chartiley = 1

function CalculateTilePosition(Tile)
    if not Tile then print("Uhh...") return end
    return 32 * (Tile - 1) + 1
end

function GetTile(TileX,TileY)
    if TileX < 1 or TileX > 25 or TileY < 1 or TileY > 14 then
        return 2
    else
        return CurrentLevel[TileY][TileX]
    end
end
function MoveEnemies(v)
    if v[4] == 1 then
        if v[3] == 1 then v[1] = v[1] + 1 elseif v[3] == 3 then v[1] = v[1] - 1 end
        if v[3] == 2 then v[2] = v[2] + 1 elseif v[3] == 4 then v[2] = v[2] - 1 end
    elseif v[4] == 2 then
        if v[3] == 1 or v[3] == 3 then v[2] = v[2] + 1 elseif v[3] == 2 or v[3] == 4 then v[2] = v[2] - 1 end
    elseif v[4] == 3 then
        if v[3] == 1 or v[3] == 3 then v[1] = v[1] + 1 elseif v[3] == 2 or v[3] == 4 then v[1] = v[1] - 1 end
    end
end

function UpdateEnemies() -- this is a mess, but at least it works.
    --[[
     Bad guy format:
     {posx,posy,direction,type}

     ]]
    if CurrentLevel.Enemies == nil then return end
    for i,v in pairs(CurrentLevel.Enemies) do
        MoveEnemies(v)
        if GetTile(v[1],v[2]) == 2 then
            if v[4] == 1 then
                if v[3] == 1 then v[1] = v[1] - 1 elseif v[3] == 3 then v[1] = v[1] + 1 end
                if v[3] == 2 then v[2] = v[2] - 1 elseif v[3] == 4 then v[2] = v[2] + 1 end
            elseif v[4] == 2 then
                if v[3] == 1 or v[3] == 3 then v[2] = v[2] - 1 elseif v[3] == 2 or v[3] == 4 then v[2] = v[2] + 1 end
            elseif v[4] == 3 then
                if v[3] == 1 or v[3] == 3 then v[1] = v[1] - 1 elseif v[3] == 2 or v[3] == 4 then v[1] = v[1] + 1 end
            end
            --if v[3] == 1 then v[1] = v[1] - 1 elseif v[3] == 3 then v[1] = v[1] + 1 elseif v[3] == 2 then v[2] = v[2] - 1 elseif v[3] == 4 then v[2] = v[2] + 1 end
            if v[4] == 1 then
                if v[3] == 4 then v[3] = 1 else v[3] = v[3] + 1 end
            elseif v[4] == 2 or v[4] == 3 then
                if v[3] == 2 then v[3] = 1 else v[3] = v[3] + 1 end
            end
            MoveEnemies(v)
            --print("Bad guy did an oopsy")
        end
        if chartilex == v[1] and chartiley == v[2] then Respawn() end
        --print("Enemy pos: "..v[1]..v[2]..v[3])
    end
end

function Respawn()
    chartilex = CurrentLevel["SpawnTileX"]
    chartiley = CurrentLevel["SpawnTileY"]
    charposx = CalculateTilePosition(chartilex)
    charposy = CalculateTilePosition(chartiley)
    timer = 0
    CurrentLevel = Maps["Level"..CurrentLevelNum]
end
function CheckCollision(d)
    if chartiley < 1 or chartilex < 1 or chartiley > 14 or chartilex > 25 then
        Respawn()
    elseif CurrentLevel[chartiley][chartilex] == 2 then
        Respawn()
    elseif CurrentLevel[chartiley][chartilex] == 3 then
        Win()
    elseif CurrentLevel[chartiley][chartilex] == 4 then
        CurrentLevel["SpawnTileX"] = chartilex
        CurrentLevel["SpawnTileY"] = chartiley
    else
        for i,v in pairs(CurrentLevel.Trees) do
            if chartilex == v[1] and chartiley == v[2] then
                print("Player at "..chartilex..","..chartiley.." moved tree at "..v[1]..","..v[2])
                if string.sub(d,2) == "x" then v[1] = d == "nx" and v[1] - 1 or v[1] + 1 end
                if string.sub(d,2) == "y" then v[2] = d == "ny" and v[2] - 1 or v[2] + 1 end
            end
        end
        for i,v in pairs(CurrentLevel.Enemies) do
            if chartilex == v[1] and chartiley == v[2] then
                Respawn()
            end
        end
    end
    if not MapLoaded then CheckCollision() return end
    if not CurrentLevel[chartiley][chartilex] then return end --This is the line that keeps erroring >:c
    if CurrentLevel[chartiley][chartilex] == 5 then
        CurrentLevel[chartiley][chartilex] = 2
    elseif CurrentLevel[chartiley][chartilex] == 6 then
        CurrentLevel[chartiley][chartilex] = 5
    elseif CurrentLevel[chartiley][chartilex] == 7 then
        CurrentLevel[chartiley][chartilex] = 5
    end
end

function CheckEnemyCollision(d,posx,posy)
    if CurrentLevel[posy][posx] == 2 then
        if d == 1 then posx = posx - 1 elseif d == 3 then posx = posx + 1 end
        if d == 1 then posy = posy - 1 elseif d == 3 then posy = posy + 1 end
        if d == 4 then d = 1 else d = d + 1 end
    end
    print(d)
    return d,posx,posy
end

function LoadLevel(Level)
    MapLoaded = false
    Maps = {}
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
    Maps.Level2 = { -- size is 25x14
        {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,5,2,2,5,5,5,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,5,2,2,5,2,5,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,5,5,5,6,5,5,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,5,2,6,6,6,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,5,2,6,5,7,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,5,5,7,6,6,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,2,2,6,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,6,7,7,6,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        ["SpawnTileX"] = 3,
        ["SpawnTileY"] = 3,
        ["Trees"] = {},
        ["Enemies"] = {}
    }
    Maps.Level3 = {
        {1,3,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2},
        {1,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2},
        {1,2,2,2,2,1,1,1,1,1,1,2,1,1,1,2,2,2,2,2,2,2,2,2,2},
        {1,1,2,1,2,1,2,2,2,2,1,2,2,1,1,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,1,2,1,2,2,1,2,2,1,1,2,4,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,1,2,2,4,2,1,2,2,1,1,2,1,2,1,2,1,2,1,2,2},
        {2,2,2,2,2,1,2,2,2,2,1,2,2,1,1,2,2,1,2,1,2,2,1,2,4},
        {2,2,2,2,2,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,1},
        {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
        {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,2,1,1,1,2,1},
        {2,2,2,2,2,1,2,2,2,2,1,1,1,1,2,2,2,1,1,1,2,2,1,2,2},
        {2,2,2,1,1,1,1,2,1,2,1,2,2,1,2,1,4,2,1,2,2,1,1,2,1},
        {2,2,2,2,1,2,1,2,2,2,1,1,1,1,2,2,2,1,1,1,2,2,1,2,2},
        {4,2,1,2,1,1,1,2,1,2,1,2,1,2,1,1,2,2,1,2,2,2,1,1,1},
        ["SpawnTileX"] = 1,
        ["SpawnTileY"] = 14,
        ["Trees"] = {},
        ["Enemies"] = {{5,13,3,1},{19,12,1,2},{11,12,3,1},{23,12,1,2},{15,1,2,2},{14,4,1,2},{6,7,3,1},{11,7,1,1}}
    }
    CurrentLevel = {}
    for i,v in pairs(Maps["Level"..Level]) do
        table.insert(CurrentLevel,v)
    end
    MapLoaded = true
    --CurrentLevel = Maps["Level"..Level] -- it always works with this line of code, but when i put a for loop it crashes :/
end

function Move(key)
    speed = 32
    tilespeed = 1
    if love.keyboard.isDown("space") then
        speed = 64
        tilespeed = 2
    end
    if key == "w" or key == "up" then
        if chartiley == 1 then return end
        charposy = charposy - speed
        chartiley = chartiley - tilespeed
        CheckCollision("ny")
    elseif key == "s" or key == "down" then
        if chartiley == 14 then return end
        charposy = charposy + speed
        chartiley = chartiley + tilespeed
        CheckCollision("py")
    elseif key == "a" or key == "left" then
        if chartilex == 1 then return end
        charposx = charposx - speed
        chartilex = chartilex - tilespeed
        CheckCollision("nx")
    elseif key == "d" or key == "right" then
        if chartilex == 25 then return end
        charposx = charposx + speed
        chartilex = chartilex + tilespeed
        CheckCollision("px")
    elseif key == "r" then
        if finished == false then
        Respawn()
        timer = 0
        else
        LoadLevel(1)
        Respawn()
        finished = false
        end
        code = ""
    elseif key == "p" then
        if debug == false then return end
        CurrentLevelNum = CurrentLevelNum + 1
        print(CurrentLevelNum)
        LoadLevel(CurrentLevelNum)
        Respawn()
        gtimer = 999999999
    elseif key == "m" then
        if muted then
            muted = false
        else
            muted = true
            love.audio.stop()
        end
    end
end

function love.load(arg)
    muted = false
    mver,ver,rver = love.getVersion()
    if ver ~= 10 then
        love.window.showMessageBox("Wrong version!","This game was made for LOVE 0.10.1. The game may malfunction.")
    end
    genseed = tonumber(arg[1])
    TileW, TileH = 32, 32
    charposx = 1
    charposy = 1
    chartilex = 1
    chartiley = 1
    terrain = love.graphics.newImage("terrain.png")
    titlescreen = love.graphics.newImage("awedd2.png")
    tree = love.graphics.newImage("bush.png")
    tiles = {}
    LoadLevel("Menu")
    --tiles[1] = love.graphics.newQuad(0,0,32,32,terrain:getDimensions())
    tiles[1] = love.graphics.newQuad(0,0,30,30,terrain:getDimensions())
    tiles[2] = love.graphics.newQuad(31,0,60,30,terrain:getDimensions())
    tiles[3] = love.graphics.newQuad(62,0,95,30,terrain:getDimensions())
    tiles[4] = love.graphics.newQuad(0,33,30,30,terrain:getDimensions())
    tiles[5] = love.graphics.newQuad(0,62,30,30,terrain:getDimensions())
    tiles[6] = love.graphics.newQuad(31,62,30,30,terrain:getDimensions())
    tiles[7] = love.graphics.newQuad(62,62,30,30,terrain:getDimensions())

    char = love.graphics.newImage("char.png")
    badguy = love.graphics.newImage("enemy.png")
    bgm1 = love.audio.newSource("bgm1.mp3")
    timer = 0

    loaded = false
    finished = false
    won = false
end

function Win()
    for i,v in pairs(CurrentLevel) do
        if i == "SpawnTileX" or i == "SpawnTileY" or i == "Trees" or i == "Enemies" then break end
        for ci,cv in pairs(v) do
            if cv == 5 or cv == 6 or cv == 7 then print("not done yet!") return end
        end
    end
    if CurrentLevelNum == 3 then
        won = true
    else
        CurrentLevelNum = CurrentLevelNum + 1
        print(CurrentLevelNum)
        LoadLevel(CurrentLevelNum)
        Respawn()
    end
end

function love.update(dt)
    debounce = debounce + dt
    if debounce >= 0.5 then
        debounce = 0
        if CurrentLevel ~= {} then UpdateEnemies() end
    end
    if loaded == true and finished == false then
        timer = timer + dt
    end
    if loaded == true and won == false then
        gtimer = gtimer + dt
    end
    if muted == false then love.audio.play(bgm1) end
end

function love.draw()
    love.graphics.setBackgroundColor(0,0,255)
    if won == true then
        local pos = love.window.toPixels(70)
        love.graphics.printf("You won! Time:"..math.floor(gtimer), pos, pos, love.graphics.getWidth() - pos)
        return
    end
    if loaded == false then
        love.graphics.draw(titlescreen,0,0,0)
        return
    end
    if CurrentLevel == nil then return end
    for rowi,rowv in pairs(CurrentLevel) do
        if rowi >= 15 then break end --== "SpawnTileX" or rowi == "SpawnTileY" or rowi == "Trees" or rowi == "Enemies"
        --print(rowv)
        if rowv == 14 then return end
        for columni,columnv in pairs(rowv) do
            love.graphics.draw(terrain, tiles[columnv], (columni-1)*TileW, (rowi-1)*TileH,0,1.06)
        end
    end
    for i,v in pairs(CurrentLevel.Trees) do
        love.graphics.draw(tree, CalculateTilePosition(v[1]), CalculateTilePosition(v[2]))
    end
    for i,v in pairs(CurrentLevel.Enemies) do
        love.graphics.draw(badguy, CalculateTilePosition(v[1]), CalculateTilePosition(v[2]))
    end
    love.graphics.draw(char,CalculateTilePosition(chartilex),CalculateTilePosition(chartiley))
    love.graphics.print({{255,255,255},"Level: "..CurrentLevelNum})
    love.graphics.print({{255,255,255},"Time: "..math.floor(timer)},0,15)
end

function love.keypressed(key,scancode,isrepeat)
    if loaded == true then
        Move(key)
    else
        LoadLevel(1)
        CurrentLevelNum = 1
        charposx = CurrentLevel["SpawnTileX"]
        charposy = CurrentLevel["SpawnTileY"]
        CheckCollision("px")
        loaded = true
    end
end