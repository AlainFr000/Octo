-- Ennemy object file

require 'util'

-- Ennemy class definition
Enemy = {}
Enemy.__index = Enemy

-- constants and timers for animation etc
local timer = 0
local frame_timer = 0
local enemy_timer = 0
local SPAWN_TIMER = 100

local distance
local animation_rate = 15
local speed = 2
local number_of_enemy = 1
math.randomseed(os.time())
local quads = {
    { -- Slime 1 walk
        { -- walk
            {1, 2, 3, 4, 5, 6, 7, 8}, -- down
            {25, 26, 27, 28, 29, 30, 31, 32}, -- up
            {9, 10, 11, 12, 13, 14, 15, 16}, -- left
            {17, 18, 19, 20, 21, 22, 23, 24}, -- right
        },
        { -- run
            {1, 2, 3, 4, 5, 6, 7, 8}, -- down
            {25, 26, 27, 28, 29, 30, 31, 32}, -- up
            {9, 10, 11, 12, 13, 14, 15, 16}, -- left
            {17, 18, 19, 20, 21, 22, 23, 24}, -- right
        }
    },
    { -- Slime 2
        { -- walk
            {1, 2, 3, 4, 5, 6, 7, 8}, -- down
            {25, 26, 27, 28, 29, 30, 31, 32}, -- up
            {9, 10, 11, 12, 13, 14, 15, 16}, -- left
            {17, 18, 19, 20, 21, 22, 23, 24}, -- right
        },
        { -- run
            {1, 2, 3, 4, 5, 6, 7, 8}, -- down
            {25, 26, 27, 28, 29, 30, 31, 32}, -- up
            {9, 10, 11, 12, 13, 14, 15, 16}, -- left
            {17, 18, 19, 20, 21, 22, 23, 24}, -- right
        }
    },
    { -- Slime 3
        { -- walk
            {1, 2, 3, 4, 5, 6, 7, 8}, -- down
            {25, 26, 27, 28, 29, 30, 31, 32}, -- up
            {9, 10, 11, 12, 13, 14, 15, 16}, -- left
            {17, 18, 19, 20, 21, 22, 23, 24}, -- right
        },
        { -- run
            {1, 2, 3, 4, 5, 6, 7, 8}, -- down
            {25, 26, 27, 28, 29, 30, 31, 32}, -- up
            {9, 10, 11, 12, 13, 14, 15, 16}, -- left
            {17, 18, 19, 20, 21, 22, 23, 24}, -- right
        }
    }
}
local height = 1080
local width = 1920
local spawn_positions = {
    {height, height + 100, 0, width},
    {-100, 0, 0, width},
    {0, height, -100, 0},
    {0, height, width, width + 100}
}

function Enemy:new()
    local self = {
        spritesheet = {
            love.graphics.newImage("graphics/enemies/Slime1/Walk/Slime1_Walk_full.png"),
            love.graphics.newImage("graphics/enemies/Slime1/Run/Slime1_Run_full.png"),
            love.graphics.newImage("graphics/enemies/Slime2/Walk/Slime2_Walk_full.png"),
            love.graphics.newImage("graphics/enemies/Slime2/Run/Slime2_Run_full.png"),
            love.graphics.newImage("graphics/enemies/Slime3/Walk/Slime3_Walk_full.png"),
            love.graphics.newImage("graphics/enemies/Slime3/Run/Slime3_Run_full.png")
        },
        size_of_quad = 64,
        status = 1,
        direction = 1,
        type_of_enemy = 1,
        frame = 1,
        speed = speed,
        position_x = 0,
        position_y = 0,
        tile = {}
    }

    self.sheettiles = {
        GenerateSprite("graphics/enemies/Slime1/Walk/Slime1_Walk_full.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/enemies/Slime1/Run/Slime1_Run_full.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/enemies/Slime2/Walk/Slime2_Walk_full.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/enemies/Slime2/Run/Slime2_Run_full.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/enemies/Slime3/Walk/Slime3_Walk_full.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/enemies/Slime3/Run/Slime3_Run_full.png", self.size_of_quad, self.size_of_quad)
    }

    local selector = math.random(4)
    self.position_x = math.random(spawn_positions[selector][1], spawn_positions[selector][2])
    self.position_y = math.random(spawn_positions[selector][3], spawn_positions[selector][4])
    self.type_of_enemy = math.random(3)
    self.status = math.random(2)

    setmetatable(self, Enemy)

    return self
end


function Enemy:draw()
    love.graphics.draw(self.spritesheet[self.status * self.type_of_enemy], self.sheettiles[self.status * self.type_of_enemy][quads[self.type_of_enemy][self.status][self.direction][self.frame]], self.position_x, self.position_y, 0, 2, 2, 32, 32)
end

function Enemy:spawn(dt)    
    enemy_timer = enemy_timer + 1
    if enemy_timer > SPAWN_TIMER then
        number_of_enemy = number_of_enemy + 1
        ENEMY_LIST[number_of_enemy] = Enemy:new()
        enemy_timer = 0
    end
end

-- Enemy update, called by player update
function Enemy:update(dt, update_position)
    local direction_x, x_delta
    local direction_y, y_delta
    timer = timer + dt
    if timer > frame_timer + animation_rate * dt then
        frame_timer = timer + animation_rate * dt
        if self.frame == 8 then
            self.frame = 1
        else
            self.frame = self.frame + 1
        end
    end
    -- calculate the distance between the player and ennemy
    x_delta = player.position_x - self.position_x
    y_delta = player.position_y - self.position_y

    -- then define the proportion of mouvement in each direction needed to reach the player, 
    -- resulting direction is unit less and the sum should represent 1
    distance = math.sqrt(x_delta * x_delta + y_delta * y_delta)
    direction_x = x_delta / distance
    direction_y = y_delta / distance

    -- we then add the actual position and direction multiplied by the speed and the delta time. 
    if update_position == 1 then
        self.position_x = self.position_x + direction_x * self.speed
    elseif update_position == 2 then
        self.position_y = self.position_y + direction_y * self.speed
    elseif update_position == 3 then
        self.position_x = self.position_x + direction_x * self.speed
        self.position_y = self.position_y + direction_y * self.speed
    end

    x_delta = player.position_x - self.position_x
    y_delta = player.position_y - self.position_y
    distance = math.sqrt(x_delta * x_delta + y_delta * y_delta)

    if distance < 16 then
        player.status = 3
        player.direction = 1
        player.frame = 1
    end
end