-- Initialisation

require 'map'

local position
local positiona
local map_source = "graphics/map/GRASS+.png"
local fullsheet
local size_of_quad = 16
local tiles
local mapCanvas
local map_needs_redraw = true


-- setting up the window size
local width = 1920
local height = 1080
local resolution = love.window.setMode( width, height)

-- map creation
local test
local test2

--function map.creation()
--end

function love.load()
    position = 0
    positiona = 300
    fullsheet = love.graphics.newImage("graphics/map/GRASS+.png")
    tiles = GenerateSprite(map_source, size_of_quad, size_of_quad)
    mapCanvas = love.graphics.newCanvas(width, height)
end

function love.update(dt) -- used to update the variable
    position = position + 1
    if position > 1000 then position = -20 end

    positiona = positiona + 1
    if positiona > 1000 then positiona = -20 end
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

