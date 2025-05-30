-- Player object file
require 'util'

-- PLayer class definition
Player = {}
Player.__index = Player

-- constants

QUADS = {
    { --idle
        {1, 2, 3, 4}, -- down
        {37, 38, 39, 40}, -- up
        {13, 14, 15, 16}, -- left
        {25, 26, 27, 28}, -- right
    },
    { --run
        {1, 2, 3, 4}, -- down
        {13, 14, 15, 16}, -- up
        {5, 6, 7, 8}, -- left
        {9, 10, 11, 12}, -- right
    }
}


function Player:new()
    local self = {
        spritesheet = {
            love.graphics.newImage("graphics/character/Unarmed_Idle/Unarmed_Idle_full.png"),
            love.graphics.newImage("graphics/character/Unarmed_Run/Unarmed_Run_full.png")
        },
        size_of_quad = 64,
        status = 1, --idle, reference to quads
        direction = 1, -- down
        frame = 1,
        position_x = 1920/2,
        position_y = 1080/2,
        tile = {},
    }

    self.sheettiles = {
        GenerateSprite("graphics/character/Unarmed_Idle/Unarmed_Idle_full.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/character/Unarmed_Run/Unarmed_Run_full.png", self.size_of_quad, self.size_of_quad)
    }

    setmetatable(self, Player)

    return self
end

function Player:draw()
    print(self.status)
    love.graphics.draw(self.spritesheet[self.status], self.sheettiles[self.status][QUADS[self.status][self.direction][self.frame]], self.position_x, self.position_y, 0, 2, 2, 32, 32)
end

function Player:update(dt)
    -- update of player sprite
    if self.frame == 4 then
        self.frame = 1
    else
        self.frame = self.frame + 1
    end
end