-- helper file for the handling of the character, his sprites, statitics etc
require 'main'
require 'util'

-- character sprites depending on the direction
local character_sprites = {
    down = {},
    up = {},
    left = {},
    right = {},
}



local character = {
    position = {x = 0, y = 0},
    speed = 100,
    sprite = nil,
    width = 16,
    height = 16,
    direction = "down",
    animation = "",
    type = "",
}

function Create_caracter(type_of_character, source_idle, source_run,size_of_quad)
    local created_character = character
    local sprites = character_sprites
    local type_of_character = type_of_character

    local tiles_idle = GenerateSprite (source_idle, size_of_quad, size_of_quad)
    if tiles_idle==nil then
        print("Error: Could not load character sprites from " .. source_idle)
        return nil
    end

    local tiles_run = GenerateSprite (source_run, size_of_quad, size_of_quad)
    if tiles_run==nil then
        print("Error: Could not load character sprites from " .. source_run)
        return nil
    end
-- to do : assign the sprites in tiles run and tiles idle to character sprite

-- to do : create the character base parameters

    return created_character
end