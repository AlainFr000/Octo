-- Initialisation

require 'map'
require 'charater'
require 'util'


-- setting up the window size
local width = 1920
local height = 1080
local resolution = love.window.setMode( width, height)

-- map variable initialisation
local map_source = "graphics/map/GRASS+.png"
local fullsheet
local size_of_quad = 16
local tiles
local mapCanvas
local map_needs_redraw = true


-- character variable initialisation
local player
local player_source_idle = "graphics/character/Unarmed_Idle/Unarmed_Idle_full.png"
local player_source_run = "graphics/character/Unarmed_Run/Unarmed_Idle_full.png"

-- map creation
local test
local test2


function love.load()
    -- map initialisation
    fullsheet = love.graphics.newImage("graphics/map/GRASS+.png")
    tiles = GenerateSprite(map_source, size_of_quad, size_of_quad)
    mapCanvas = love.graphics.newCanvas(width, height)
    player = Create_caracter("player", player_source_idle, player_source_run, size_of_quad)

end

function love.update(dt) -- used to update the variable
-- to do
end

function love.draw() -- used to refresh the graphics based on the variable
    if map_needs_redraw == true then -- redraw the map if needed
        love.graphics.setCanvas(mapCanvas)  
        Draw_map(fullsheet, tiles, width, height, size_of_quad)
        love.graphics.setCanvas()
        map_needs_redraw = false
    end
    -- Draw the image of the map
    love.graphics.draw(mapCanvas, 0, 0)
end

