--  Map object file

require 'util'
require 'playerObject'
require 'ennemyObject'


-- Map class definition
Map = {}
Map.__index = Map

-- constants

MAP_WIDTH = 120
MAP_HEIGHT = 68

MAP_TYPE = {
    1,
    2,
    3,
    -- 1 = night, 2 = day, 3 = desert
}

-- random choice for the map type
math.randomseed(os.time())
MAP_CHOICE = math.random(1,#MAP_TYPE)
VOID_TILE = 87 -- tile used when nothing needs to be rendered

-- definition of the spritesheet quad to be used depending on the map type
QUAD = {
    { -- night
        STRUCTURE = {276, 276, 276, 277, 277, 278},
        ADDITIONAL = {338, 339, 340}
    },
    { -- day
        STRUCTURE = {1, 1, 53, 53, 101, 101},
        ADDITIONAL = {305, 306, 307}
    },
    { -- desert
        STRUCTURE = {2, 2, 54, 54, 102, 102},
        ADDITIONAL = {308, 309, 310}
    }
}

-- constructor for the Map class

function Map:new()
    -- definition of the map object
    local self={
        fullsheet = love.graphics.newImage("graphics/map/GRASS+.png"),
        size_of_quad = 16,
        tiles_in_height = MAP_HEIGHT,
        tiles_in_width = MAP_WIDTH,
        mapchoice = MAP_CHOICE,-- status of the time of the day
        struct_tiles = {},
        addi_tiles = {},
    }

    self.sheettiles = GenerateSprite("graphics/map/GRASS+.png", self.size_of_quad, self.size_of_quad)
    -- once the object is created we setmetatable for OOP
    setmetatable(self, Map)

    -- set the map tiles with some randomisation
    for i = 1, self.tiles_in_height, 1 do
        for j = 1, self.tiles_in_width, 1 do
            self:setstructTile(i, j, QUAD[self.mapchoice].STRUCTURE[math.random(6)]) -- choose a random tile within the quad structure table defined above
            if math.random(0, 100) < 4 then
                self:setaddiTile(i, j, QUAD[self.mapchoice].ADDITIONAL[math.random(3)]) -- draw some random artefacts
            else
                self:setaddiTile(i, j, VOID_TILE) -- no additional tile
            end
        end
    end

    return self

end

function Map:draw()
    for i = 1, self.tiles_in_height, 1 do
        for j = 1, self.tiles_in_width, 1 do
            love.graphics.draw(self.fullsheet, self.sheettiles[self:getstructTile(i, j)], (j - 1) * self.size_of_quad, (i - 1) * self.size_of_quad) -- draw a random tile depending on the day or night
            love.graphics.draw(self.fullsheet, self.sheettiles[self:getaddiTile(i, j)], (j - 1) * self.size_of_quad, (i - 1) * self.size_of_quad)
        end
    end
end

function Map:setstructTile(x, y, tile) -- set the tile at position (x, y) to the specified tile
    self.struct_tiles[self.tiles_in_height * (x - 1)+ y] = tile
end

function Map:setaddiTile(x, y, tile) -- set the tile at position (x, y) to the specified tile
    self.addi_tiles[self.tiles_in_height * (x - 1)+ y] = tile
end

function Map:getstructTile(x, y) -- get the tile at position (x, y)
    return self.struct_tiles[self.tiles_in_height * (x - 1) + y]
end

function Map:getaddiTile(x, y) -- get the tile at position (x, y)
    return self.addi_tiles[self.tiles_in_height * (x - 1) + y]
end

function Map:append(direction)
    -- this function is used to append the map on the screen based on the character direction
end
