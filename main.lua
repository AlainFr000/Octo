-- Initialisation


require 'mapObject'
require 'playerObject'
require 'enemyObject'
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
ENEMY_LIST[1] = Enemy:new()

function love.load()
end

function love.update(dt) -- used to update the variable
    

    player:update(dt)
    if player.status ~= 3 then
        Enemy:spawn(dt)
        player:scoring(dt)
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

    -- draw the score
    if player.status ~= 3 then
        love.graphics.printf("Score :" .. player.score, 0, 0, 1000, "left", 0, 3, 3)
    else
        love.graphics.printf("YOU LOST, YOUR SCORE IS ".. player.score, 0, 1080/2, 200, "center", 0, 8, 8)
        print("lol")
    end
    -- Draw the player character
    player:draw()
end

