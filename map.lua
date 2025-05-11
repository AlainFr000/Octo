-- helper file for main.lua

Partimage = function ( source, tilenumber )

    local tile= {}
    for i = tilenumber*16, (tilenumber+1)*16-1, 1 do
        tile[i] = {}
        for j = tilenumber*16, (tilenumber+1)*16-1, 1 do
            if source[i] and source[i][j] then
                love.graphics.NewQuad(i, j, 16, 16, source:getDimensions())
            end
        end

    end

    return tile
end

-- tilewidith and tileheight are the size of the each individual sprite in the sprite sheet
function GenerateSprite (fullsheet, tilewidth, tileheight)
    local fullsheetWidth = fullsheet:getWidth() / tilewidth -- give the number of sprite in x absis
    local fullsheetHeight = fullsheet:getHeight() / tileheight -- give the number of sprite in y absis
    
    local tilenumber = 0
    local tile = {}
    for i = 0, fullsheetHeight - 1 do

        for j = 0, fullsheetWidth - 1 do 
            tile[tilenumber] = love.graphics.NewQuad(i * tilewidth, j * tileheight, tilewidth, tileheight, fullsheet:getDimensions())
        end
        
    end

    return tile
end