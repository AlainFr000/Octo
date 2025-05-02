-- Initialisation

--local map = require ("map.lua")


local position
local positiona

-- setting up the window size
local width = 1920
local height = 1080
local resolution = love.window.setMode( width, height)

-- map creation
local test
local test2

partimage()

--function map.creation()
--end

function partimage( source, tilenumber )
    local i = tilenumber
    local tile = {}
    for i = tilenumber*16, ((tilenumber+1)*16-1), 1 do

        for j = tilenumber*16, ((tilenumber+1)*16-1), 1 do
           tile [i][j] = source[i][j]
        end

    end

    return tile
end

function love.load()
    position = 0
    positiona = 300
    test2 = partimage(love.graphics.newImage("graphics/map/GRASS+.png"), 1)
end

function love.update(dt) -- used to update the variable
    position = position + 1
    if position > 1000 then position = -20 end

    positiona = positiona + 1
    if positiona > 1000 then positiona = -20 end
end

function love.draw() -- used to refresh the graphics based on the variable
    love.graphics.print('Hello World!', position, 300)
    love.graphics.print('Hello World!', positiona, 300)
    love.graphics.draw(test2, position, height/2)
end