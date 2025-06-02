-- Player object file
require 'util'

-- PLayer class definition
Player = {}
Player.__index = Player

-- constants and timers for animation purpose
local frame_timer = 0
local frame_timer_map = 0
local timer = 0
local timer_map = 0


ANIMATION_RATE = 30
MAP_REFRESH_RATE = 5
SPEED = 1
QUADS = {
    { --idle
        {1, 2, 3, 4}, -- down
        {37, 38, 39, 40}, -- up
        {13, 14, 15, 16}, -- left
        {25, 26, 27, 28}, -- right
    },
    { --run
        {1, 2, 3, 4, 5, 6, 7, 8}, -- down
        {25, 26, 27, 28, 29, 30, 31, 32}, -- up
        {9, 10, 11, 12, 13, 14, 15, 16}, -- left
        {17, 18, 19, 20, 21, 22, 23, 24}, -- right
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
        speed = SPEED,
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
    love.graphics.draw(self.spritesheet[self.status], self.sheettiles[self.status][QUADS[self.status][self.direction][self.frame]], self.position_x, self.position_y, 0, 2, 2, 32, 32)
end

function Player:update(dt)
    local update
    -- update of player sprite
    timer = timer + dt
    if timer > frame_timer + ANIMATION_RATE * dt then
        update = true
        frame_timer = timer + ANIMATION_RATE * dt
        if self.frame == 4 then
            self.frame = 1
        else
            self.frame = self.frame + 1
        end
    end
    -- calculation for updating the map borders
    timer_map = timer_map + dt
    if timer_map > frame_timer_map + MAP_REFRESH_RATE * dt then
        update = true
        frame_timer_map = timer_map + MAP_REFRESH_RATE * dt
    end

    -- update player position and sprites accordingly
    if love.keyboard.isDown("right") and love.keyboard.isDown("down") then
        self.status = 2
        if map.border[1] - self.position_y > map.render_distance then
            self.position_y = self.position_y + self.speed / math.sqrt(2)
            self.direction = 1
        end
        if map.border[4] - self.position_x > map.render_distance then
            self.position_x = self.position_x + self.speed / math.sqrt(2)
            self.direction = 4
        end

    elseif love.keyboard.isDown("left") and love.keyboard.isDown("down") then
        self.status = 2
        if map.border[1] - self.position_y > map.render_distance then
            self.position_y = self.position_y + self.speed / math.sqrt(2)
            self.direction = 1
        end
        if self.position_x - map.border[3] > map.render_distance then
            self.position_x = self.position_x - self.speed / math.sqrt(2)
            self.direction = 3
        end

    elseif love.keyboard.isDown("right") and love.keyboard.isDown("up") then
        self.status = 2
        if self.position_y - map.border[2] > map.render_distance then
            self.position_y = self.position_y - self.speed / math.sqrt(2)
            self.direction = 2
        end
        if map.border[4] - self.position_x > map.render_distance then
            self.position_x = self.position_x + self.speed / math.sqrt(2)
            self.direction = 4
        end

    elseif love.keyboard.isDown("left") and love.keyboard.isDown("up") then
        self.status = 2
        if self.position_y - map.border[2] > map.render_distance then
            self.position_y = self.position_y - self.speed / math.sqrt(2)
            self.direction = 2
        end
        if self.position_x - map.border[3] > map.render_distance then
            self.position_x = self.position_x - self.speed / math.sqrt(2)
            self.direction = 3
        end

    elseif love.keyboard.isDown("down") then
        if map.border[1] - self.position_y > map.render_distance then
            self.position_y = self.position_y + self.speed
        else
            map:append(self.direction, update)
        end
        self.direction = 1
        self.status = 2

    elseif love.keyboard.isDown("up") then
        if self.position_y - map.border[2] > map.render_distance then
            self.position_y = self.position_y - self.speed
        else
            map:append(self.direction, update)
        end
        self.direction = 2
        self.status = 2

    elseif love.keyboard.isDown("left") then
        if self.position_x - map.border[3] > map.render_distance then
            self.position_x = self.position_x - self.speed
        else
            map:append(self.direction, update)
        end
        self.direction = 3
        self.status = 2

    elseif love.keyboard.isDown("right") then
        if map.border[4] - self.position_x > map.render_distance then
            self.position_x = self.position_x + self.speed
        end
        self.direction = 4
        self.status = 2
    else
        self.status = 1
    end
end

