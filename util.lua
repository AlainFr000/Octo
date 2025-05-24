-- util function for global uses
require 'main'
-- tilewidith and tileheight are the size of the each individual sprite in the sprite sheet -- 
-- here we generate one quad for each sprite in the sprite sheet and then attribute it a number.
-- This number will be called after to generate the map

function GenerateSprite (source, tilewidth, tileheight)

    local fullsheet = love.graphics.newImage(source) -- load the sprite sheet
    
    if fullsheet == nil then
        return nil
    else
        local fullsheetWidth = fullsheet:getWidth() / tilewidth -- give the number of sprite in x absis
        local fullsheetHeight = fullsheet:getHeight() / tileheight -- give the number of sprite in y absis
    
        local tilenumber = 0
        local tile = {}
        for i = 0, fullsheetHeight - 1 do

            for j = 0, fullsheetWidth - 1 do 
                tile[tilenumber] = love.graphics.newQuad(j * tilewidth, i * tileheight, tilewidth, tileheight, fullsheet:getDimensions())
                tilenumber = tilenumber + 1
            end
            
        end

        return tile
    end

end