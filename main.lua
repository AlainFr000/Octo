-- Initialisation

require 'map'


local position
local positiona
local source = love.graphics.newImage ("graphics/map/GRASS+.png")


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
    
    if source ~= nil
    then 
        test2 = love.graphics.newQuad(0, 0, 16, 16, source:getDimensions())
    end
    --test2 = Partimage(love.graphics.newImage("graphics/map/GRASS+.png"), 1)
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
    love.graphics.draw(source, test2, position, height/2)
end

