--  Map object file

require 'util'
require 'playerObject'
require 'enemyObject'


-- Map class definition
Map = {}
Map.__index = Map

-- constants

MAP_WIDTH = 120
MAP_HEIGHT = 68

BORDER = {
    LEFT = 0,
    RIGHT = MAP_WIDTH * 16,
    TOP = 0,
    BOT = MAP_HEIGHT * 16
}

MAP_TYPE = {
    1,
    2,
    3,
    -- 1 = night, 2 = day, 3 = desert
}
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
R1 = #QUAD[1].STRUCTURE
R2 = #QUAD[1].ADDITIONAL
R3 = "undefined"

-- random choice for the map type
math.randomseed(os.time())
MAP_CHOICE = math.random(1,#MAP_TYPE)
VOID_TILE = 87 -- tile used when nothing needs to be rendered


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
        border = {MAP_HEIGHT * 16, 0, 0,MAP_WIDTH * 16}, -- down, up, left, right
        render_distance = 20 * 16, -- tiles x size of tile
    }

    self.sheettiles = GenerateSprite("graphics/map/GRASS+.png", self.size_of_quad, self.size_of_quad)
    -- once the object is created we setmetatable for OOP
    setmetatable(self, Map)

    -- set the map tiles with some randomisation
    self:procedural(1, self.tiles_in_height, 1, self.tiles_in_width, R1, R2, R3)

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
    self.struct_tiles[self.tiles_in_width * (x - 1) + y] = tile
end

function Map:setaddiTile(x, y, tile) -- set the tile at position (x, y) to the specified tile
    self.addi_tiles[self.tiles_in_width * (x - 1) + y] = tile
end

function Map:getstructTile(x, y) -- get the tile at position (x, y)
    return self.struct_tiles[self.tiles_in_width * (x - 1) + y]
end

function Map:getaddiTile(x, y) -- get the tile at position (x, y)
    return self.addi_tiles[self.tiles_in_width * (x - 1) + y]
end

function Map:procedural(height_start, height_end, length_start, length_end, r1, r2, r3) -- we input the size of the area to procedurally draw.
    -- would replace procedurally select the quad for tiles (depends on context)
    for i = height_start, height_end, 1 do
        for j = length_start, length_end, 1 do
            self:setstructTile(i, j, QUAD[self.mapchoice].STRUCTURE[math.random(r1)]) -- choose a random tile within the quad structure table defined above
            if math.random(0, 100) < 4 then
                self:setaddiTile(i, j, QUAD[self.mapchoice].ADDITIONAL[math.random(r2)]) -- draw some random artefacts
            else
                self:setaddiTile(i, j, VOID_TILE) -- no additional tile
            end
        end
    end
end

function Map:append(direction, update)
    -- this function is used to append the map on the screen based on the character direction
    -- the appending occur if the player is too close from the border, and adds a random layer if so, as well as translating the camera
    
    if direction == 1 and update == true then
        for i = 1, self.tiles_in_height - 1, 1 do -- reproduce the map but translated by 1 line.
            for j = 1, self.tiles_in_width, 1 do
                self:setstructTile(i, j, self:getstructTile(i + 1, j))
                if self:getaddiTile(i + 1, j) ~= VOID_TILE then
                    self:setaddiTile(i, j, self:getaddiTile(i + 1, j))
                else
                    self:setaddiTile(i, j, VOID_TILE) -- no additional tile
                end
            end

        end
        -- then the new line is drawn
        self:procedural(self.tiles_in_height, self.tiles_in_height, 1, self.tiles_in_width, R1, R2, R3)
    end

    if direction == 2 and update == true then
        for i = self.tiles_in_height, 2, -1 do -- reproduce the map but translated by 1 line.
            for j = self.tiles_in_width, 1 , - 1 do
                self:setstructTile(i, j, self:getstructTile(i - 1, j))
                if self:getaddiTile(i - 1, j) ~= VOID_TILE then
                    self:setaddiTile(i, j, self:getaddiTile(i - 1, j))
                else
                    self:setaddiTile(i, j, VOID_TILE) -- no additional tile
                end
            end

        end
        -- then the new line is drawn
        self:procedural(1, 1, 1, self.tiles_in_width, R1, R2, R3)
    end

    if direction == 3 and update == true then
        for i = self.tiles_in_height, 1, -1 do -- reproduce the map but translated by 1 line.
            for j = self.tiles_in_width, 2, -1 do
                -- Shift structural tiles
                self:setstructTile(i, j, self:getstructTile(i, j - 1))
                -- Shift additional tiles
                if self:getaddiTile(i, j - 1) ~= VOID_TILE then
                    self:setaddiTile(i, j, self:getaddiTile(i, j - 1))
                else
                    self:setaddiTile(i, j, VOID_TILE)
                end
            end
        end
        -- then the new line is drawn
        self:procedural(1, self.tiles_in_height, 1, 1, R1, R2, R3)
    end

    if direction == 4 and update == true then
        for i = self.tiles_in_height, 1, -1 do -- reproduce the map but translated by 1 line.
            for j = 1, self.tiles_in_width - 1, 1 do
                -- Shift structural tiles
                self:setstructTile(i, j, self:getstructTile(i, j + 1))
                -- Shift additional tiles
                if self:getaddiTile(i, j + 1) ~= VOID_TILE then
                    self:setaddiTile(i, j, self:getaddiTile(i, j + 1))
                else
                    self:setaddiTile(i, j, VOID_TILE)
                end
            end
        end
        -- then the new line is drawn
        self:procedural(1, self.tiles_in_height, self.tiles_in_width, self.tiles_in_width, R1, R2, R3)
    end
end
