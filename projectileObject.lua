-- Ennemy object file

require 'util'

-- Ennemy class definition
Projectile = {}
Projectile.__index = Projectile

-- constants and timers for animation etc
local speed = 4
math.randomseed(os.time())
local timer = 0
local frame_timer = 0
local fire_timer = 0
local number_of_projectile = 1

local animation_rate = 15
local fireCD = 1000


local quads = 
    { -- weapon 1
    {
        1, 2, 3, 4, 5, -- frame of the weapon 1
    }
}

function Projectile:new()
    local self = {
        spritesheet = {
            love.graphics.newImage("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_00.png"),
            love.graphics.newImage("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_01.png"),
            love.graphics.newImage("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_02.png"),
            love.graphics.newImage("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_03.png"),
            love.graphics.newImage("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_04.png"),
            love.graphics.newImage("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_05.png"),
            love.graphics.newImage("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_06.png"),
            love.graphics.newImage("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_07.png")
        },
        size_of_quad = 16,
        color_of_projectile = math.random(8),
        type_of_projectile = 1,
        frame = 1,
        direction = player.direction,
        speed = speed,
        position_x = player.position_x,
        position_y = player.position_y,
        tile = {}
    }

    self.sheettiles = {
        GenerateSprite("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_00.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_01.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_02.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_03.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_04.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_05.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_06.png", self.size_of_quad, self.size_of_quad),
        GenerateSprite("graphics/projectiles/All_Fire_Bullet_Pixel_16x16_07.png", self.size_of_quad, self.size_of_quad)
    }

    setmetatable(self, Projectile)

    return self

end

function Projectile:draw()
    love.graphics.draw(self.spritesheet[self.color_of_projectile], self.sheettiles[self.color_of_projectile][quads[self.type_of_projectile][self.frame]], self.position_x, self.position_y, 1, 1, 2, 2)
end

function Projectile:reset()
    timer = 0
    frame_timer = 0
    fire_timer = 0
    number_of_projectile = 1
end

function Projectile:update(dt, update_position)
    local direction_mod_y
    local direction_mod_x

    local x_delta, y_delta, distance
    timer = timer + dt
    if timer > frame_timer + animation_rate * dt then
        frame_timer = timer + animation_rate * dt

        if self.frame == 5 then
            self.frame = 1
        else
            self.frame = self.frame + 1
        end
    end
    if self.direction == 1 then
        direction_mod_y = 1
        direction_mod_x = 0
    elseif self.direction == 2 then
        direction_mod_y = -1
        direction_mod_x = 0
    elseif self.direction == 3 then
        direction_mod_y = 0
        direction_mod_x = -1
    elseif self.direction == 4 then
        direction_mod_y = 0
        direction_mod_x = 1
    end
    if update_position == 1 then
        self.position_x = self.position_x + self.speed * direction_mod_x
    elseif update_position == 2 then
        self.position_y = self.position_y + self.speed * direction_mod_y
    elseif update_position == 3 then
        self.position_x = self.position_x + self.speed * direction_mod_x
        self.position_y = self.position_y + self.speed * direction_mod_y
    end

    for i, enemy in ipairs(ENEMY_LIST) do
        local x_delta = enemy.position_x - self.position_x
        local y_delta = enemy.position_y - self.position_y
        local distance = math.sqrt(x_delta * x_delta + y_delta * y_delta)
        if distance < 32 then
            enemy.position_x = -1e18 
            enemy.position_y = -1e18
            self.position_x = 1e18
            self.position_y = 1e18
            self.direction = 1
            player:additional_scoring()
            break
        end
end

end

function Projectile:spawn()
    number_of_projectile = number_of_projectile + 1
    PROJECTILE_LIST[number_of_projectile] = Projectile:new()
end