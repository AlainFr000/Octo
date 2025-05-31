-- Initialisation


require 'mapObject'
require 'playerObject'
require 'ennemyObject'
require 'util'


-- setting up the window size
local width = 1920
local height = 1080
local resolution = love.window.setMode( width, height)

-- map initialisation
map = Map:new() -- create a new map object

-- character variable initialisation
player = Player:new() -- create the player object



function love.load()

end

function love.update(dt) -- used to update the variable

    player:update(dt)
    map:append()

end


function love.draw() -- used to refresh the graphics based on the variable
    -- Draw the image of the map
    map:draw()
    -- Draw the player character
    player:draw()
    

end

