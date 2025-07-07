-- Initialisation


require 'mapObject'
require 'playerObject'
require 'enemyObject'
require 'projectileObject'
require 'util'


-- setting up the window size
WIDTH = 1920
HEIGHT = 1080
local resolution = love.window.setMode(WIDTH, HEIGHT)

-- map initialisation
map = Map:new() -- create a new map object

-- character variable initialisation
player = Player:new() -- create the player object
ENEMY_LIST = {}
PROJECTILE_LIST = {}
ENEMY_LIST[1] = Enemy:new()
PROJECTILE_LIST[1] = Projectile:new()
Firetimer = 0
FireCD = 1000

function love.load()
end

function love.update(dt) -- used to update the variable
    

    player:update(dt)
    if player.status ~= 3 then
        Enemy:spawn(dt)
        player:scoring(dt)

        Firetimer = Firetimer + dt * 1000
        if love.keyboard.isDown("space") then
            if Firetimer > FireCD then
            Firetimer = 0
            Projectile:spawn()
            end
        end

    else
    end

end


function love.draw() -- used to refresh the graphics based on the variable
    -- Draw the image of the map
    map:draw()

    -- draw the enemies
    for i = 1, #ENEMY_LIST, 1 do
        ENEMY_LIST[i]:draw()
    end

    for i = 1, #PROJECTILE_LIST, 1 do
        PROJECTILE_LIST[i]:draw()
    end

    -- draw the score
    if player.status ~= 3 then
        love.graphics.printf("Score :" .. player.score, 0, 0, 1000, "left", 0, 3, 3)
    else
        love.graphics.printf("YOU LOST, YOUR SCORE IS ".. player.score, 0, 1080/2, 200, "center", 0, 8, 8)

    end
    -- Draw the player character
    player:draw()
end

