-- Initialisation


require 'mapObject'
require 'playerObject'
require 'enemyObject'
require 'util'


-- setting up the window size
local width = 1920
local height = 1080
local resolution = love.window.setMode(width, height)

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
    Updater(dt)
end


function love.draw() -- used to refresh the graphics based on the variable
    -- Draw the image of the map
    map:draw()
    -- Draw the player characters
    player:draw()
    for i = 1, #ENEMY_LIST, 1 do
        ENEMY_LIST[i]:draw()
    end
end

