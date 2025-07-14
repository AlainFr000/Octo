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
BEST_SCORE = 0

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
    elseif player.status == 3 then
        if love.keyboard.isDown("space") then
            PROJECTILE_LIST = {}
            ENEMY_LIST = {}
            ENEMY_LIST[1] = Enemy:new()
            PROJECTILE_LIST[1] = Projectile:new()
            if BEST_SCORE < player.score then
                BEST_SCORE = player.score
            end
            player:reset()
            Enemy:reset()
            Projectile:reset()
            map:reset()
        end
    end

end


function love.draw() -- used to refresh the graphics based on the variable
    -- Draw the image of the map
    map:draw()

    -- draw the enemies
    for i, enemy in ipairs(ENEMY_LIST) do
        enemy:draw()
    end
    for i, projectile in ipairs(PROJECTILE_LIST) do
        projectile:draw()
    end

    -- draw the score
    if player.status ~= 3 then
        love.graphics.printf("Best score:".. BEST_SCORE, 1500, 0, 1000, "left", 0, 3, 3 )
        love.graphics.printf("Score :" .. player.score, 0, 0, 1000, "left", 0, 3, 3)
    else
        love.graphics.printf("YOU LOST, YOUR SCORE IS ".. player.score, 350, 400, 200, "center", 0, 6, 6)
        love.graphics.printf("Best score is:".. BEST_SCORE, 350, 550, 200, "center", 0, 6, 6)

            if BEST_SCORE < player.score then
                love.graphics.printf("NEW BEST SCORE !!", 350, 700, 200, "center", 0, 6, 6)
            end
        love.graphics.printf("Press space to play again", 350, 850, 200, "center", 0, 6, 6)
    end
    -- Draw the player character
    player:draw()
end

