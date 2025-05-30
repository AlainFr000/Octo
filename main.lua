-- Initialisation

require 'map'
require 'mapObject'
require 'character'
require 'util'


-- setting up the window size
local width = 1920
local height = 1080
local resolution = love.window.setMode( width, height)

-- map variable initialisation
map = Map:new() -- create a new map object

-- character variable initialisation
local player = Character
local size_of_quad_character = 64
local player_sprites = {}
local player_source_idle = "graphics/character/Unarmed_Idle/Unarmed_Idle_full.png"
local player_source_run = "graphics/character/Unarmed_Run/Unarmed_Run_full.png"


function love.load()

end

function love.update(dt) -- used to update the variable


end

function love.draw() -- used to refresh the graphics based on the variable
    -- Draw the image of the map
    map:draw()
    -- Draw the player character

end

