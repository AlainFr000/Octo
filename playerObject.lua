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


local animation_rate = 15
local map_refresh_rate = 3
local speed = 3
local quads = {
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
    },
    { --death
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
            love.graphics.newImage("graphics/character/Unarmed_Run/Unarmed_Run_full.png"),
            love.graphics.newImage("graphics/character/Unarmed_Death/Unarmed_Death_full.png")
        },
        size_of_quad = 64,
        status = 1, --idle, or runing, or deadreference to quads
        direction = 1, -- down
        frame = 1,
        speed = speed,
        position_x = 1920/2,
        position_y = 1080/2,
        score = 0,
        tile = {},
    }

    self.sheettiles = {
        GenerateSprite("graphics/character/Unarmed_Idle/Unarmed_Idle_full.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/character/Unarmed_Run/Unarmed_Run_full.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/character/Unarmed_Death/Unarmed_Death_full.png", self.size_of_quad, self.size_of_quad)
    }

    setmetatable(self, Player)

    return self
end

function Player:scoring(dt)
    if self.status ~= 3 then 
        self.score = self.score + 1 * #ENEMY_LIST
    end
    
end

function Player:draw()
    love.graphics.draw(self.spritesheet[self.status], self.sheettiles[self.status][quads[self.status][self.direction][self.frame]], self.position_x, self.position_y, 0, 2, 2, 32, 32)
end

-- used for update on the player object. Also it enable the enemy mouvement
function Player:update(dt)
    local update, update_enemy_position
    -- update of player sprite
    timer = timer + dt
    if timer > frame_timer + animation_rate * dt then
        update = true
        frame_timer = timer + animation_rate * dt
        if self.frame == 4 and self.status ~= 3 then
            self.frame = 1
        elseif self.frame == 7 then
            self.frame = 7

        else
            self.frame = self.frame + 1
        end
    end
    -- calculation for updating the map borders
    timer_map = timer_map + dt
    if timer_map >= frame_timer_map + map_refresh_rate * dt then
        update = true
        frame_timer_map = timer_map + map_refresh_rate * dt
    end

    -- update player position and sprites accordingly if not dead
    
    if self.status ~= 3 then 
        if love.keyboard.isDown("right") and love.keyboard.isDown("down") then
            self.status = 2
            if map.border[1] - self.position_y >= map.render_distance then
                self.position_y = self.position_y + self.speed / math.sqrt(2)
                self.direction = 1
                update_enemy_position = 3
            else
                self.direction = 1
                map:append(self.direction, update)
                update_enemy_position = 1
            end
            if map.border[4] - self.position_x >= map.render_distance then
                self.position_x = self.position_x + self.speed / math.sqrt(2)
                self.direction = 4
                update_enemy_position = 3
            else
                self.direction = 4
                map:append(self.direction, update)
                update_enemy_position = 2
            end

        elseif love.keyboard.isDown("left") and love.keyboard.isDown("down") then
            self.status = 2
            if map.border[1] - self.position_y >= map.render_distance then
                self.position_y = self.position_y + self.speed / math.sqrt(2)
                self.direction = 1
                update_enemy_position = 3
            else
                self.direction = 1
                map:append(self.direction, update)
                update_enemy_position = 1
            end
            if self.position_x - map.border[3] >= map.render_distance then
                self.position_x = self.position_x - self.speed / math.sqrt(2)
                self.direction = 3
                update_enemy_position = 3
            else
                self.direction = 3
                map:append(self.direction, update)
                update_enemy_position = 2
            end

        elseif love.keyboard.isDown("right") and love.keyboard.isDown("up") then
            self.status = 2
            if self.position_y - map.border[2] >= map.render_distance then
                self.position_y = self.position_y - self.speed / math.sqrt(2)
                self.direction = 2
                update_enemy_position = 3
            else
                self.direction = 2
                map:append(self.direction, update)
                update_enemy_position = 1
            end
            if map.border[4] - self.position_x >= map.render_distance then
                self.position_x = self.position_x + self.speed / math.sqrt(2)
                self.direction = 4
                update_enemy_position = 3
            else
                self.direction = 4
                map:append(self.direction, update)
                update_enemy_position = 2
            end

        elseif love.keyboard.isDown("left") and love.keyboard.isDown("up") then
            self.status = 2
            if self.position_y - map.border[2] >= map.render_distance then
                self.position_y = self.position_y - self.speed / math.sqrt(2)
                self.direction = 2
                update_enemy_position = 3
            else
                self.direction = 2
                map:append(self.direction, update)
                update_enemy_position = 1
            end
            if self.position_x - map.border[3] >= map.render_distance then
                self.position_x = self.position_x - self.speed / math.sqrt(2)
                self.direction = 3
                update_enemy_position = 3
            else
                self.direction = 3
                map:append(self.direction, update)
                update_enemy_position = 2
            end

        elseif love.keyboard.isDown("down") then
            if map.border[1] - self.position_y >= map.render_distance then
                self.position_y = self.position_y + self.speed
                update_enemy_position = 3
            else
                map:append(self.direction, update)
                update_enemy_position = 1
            end
            self.direction = 1
            self.status = 2

        elseif love.keyboard.isDown("up") then
            if self.position_y - map.border[2] >= map.render_distance then
                self.position_y = self.position_y - self.speed
                update_enemy_position = 3
            else
                map:append(self.direction, update)
                update_enemy_position = 1
            end
            self.direction = 2
            self.status = 2

        elseif love.keyboard.isDown("left") then
            if self.position_x - map.border[3] >= map.render_distance then
                self.position_x = self.position_x - self.speed
                update_enemy_position = 3
            else
                map:append(self.direction, update)
                update_enemy_position = 2
            end
            self.direction = 3
            self.status = 2

        elseif love.keyboard.isDown("right") then
            if map.border[4] - self.position_x >= map.render_distance then
                self.position_x = self.position_x + self.speed
                update_enemy_position = 3
            else
                map:append(self.direction, update)
                update_enemy_position = 2
            end
            self.direction = 4
            self.status = 2
            
        else
            self.status = 1
            update_enemy_position = 3
        end

        for i = 1, #ENEMY_LIST, 1 do
            ENEMY_LIST[i]:update(dt, update_enemy_position)
        end

        
        for i = 1, #PROJECTILE_LIST, 1 do
            PROJECTILE_LIST[i]:update(dt, update_enemy_position)
        end
    end
end

