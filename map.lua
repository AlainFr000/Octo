-- helper file for main.lua
require 'main'
require 'util'




-- this function will draw the map on the screen with some randomisation see the graphics/map/GRASS+.png
function Draw_map(fullsheet, quad, width, height, size_of_quad)
    
    math.randomseed(os.time())
    local tile_in_width = width / size_of_quad
    local tile_in_height = height / size_of_quad
    local timecycle ={
        {275, 275, 275, 276, 276, 277},
        {0, 52, 100, 0, 52, 100},
        {1, 53, 101, 1, 53, 101}
    } -- table of location for the sprite of the map for night and morning or noun
    local plants = {
        {337, 338, 339},
        {304, 305, 306},
        {307, 308, 309}
    } -- table of location for the sprite of the plants for night and morning or noun

    local time_of_day = math.random(1, 3) -- randomly select a time of thge day

    for i = 0, tile_in_height -1 do
        for j = 0, tile_in_width -1 do
            love.graphics.draw(fullsheet, quad[timecycle[time_of_day][math.random(6)]], j * size_of_quad, i * size_of_quad) -- draw a random tile depending on the day or night
            if math.random(0, 100) < 4 then
                love.graphics.draw(fullsheet, quad[plants[time_of_day][math.random(3)]], j * size_of_quad, i * size_of_quad) -- draw some random mushrooms
            end
        end
    end
    
    
end