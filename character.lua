-- helper file for the handling of the character, his sprites, statitics etc
require 'util'

-- character sprites depending on the direction
Character_sprites = {
    down = {},
    up = {},
    left = {},
    right = {},
}

-- basic character param
Character = {
    position = {x = 1920/2 , y = 1080/2}, 
    speed = 100,
    current_quad = nil,
    quad = {idle = Character_sprites, run = Character_sprites},
    width = 16,
    height = 16,
    direction = "down",
    animation = "idle",
    type = "player",
}

function Create_character(type_of_character, source_idle, source_run, size_of_quad)
    local created_character = Character
    local run_sprites, idle_sprites = Character_sprites, Character_sprites

    
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
-- assign the sprites in tiles run and tiles idle to character sprite. This could be done abstracting to another function but not really of much use
    
    if type_of_character == "player" then
        created_character.type = "player"
        idle_sprites = {
            down = {tiles_idle[0], tiles_idle[1], tiles_idle[2], tiles_idle[3]},
            up = {tiles_idle[36], tiles_idle[37], tiles_idle[38], tiles_idle[39]},
            left = {tiles_idle[12], tiles_idle[13], tiles_idle[14], tiles_idle[15]},
            right = {tiles_idle[24], tiles_idle[25], tiles_idle[26], tiles_idle[27]},
        }

        run_sprites = {
            down = {tiles_run[0], tiles_run[1], tiles_run[2], tiles_run[3]},
            up = {tiles_run[12], tiles_run[13], tiles_run[14], tiles_run[15]},
            left = {tiles_run[4], tiles_run[5], tiles_run[6], tiles_run[7]},
            right = {tiles_run[8], tiles_run[9], tiles_run[10], tiles_run[11]},
        }
        created_character.quad = {idle_sprites, run_sprites}
        created_character.current_quad = created_character.quad[1].down[1]

    else
        -- to do for ennemies or other characters
    end

    return created_character
end

function Draw_Character(character, sprite, quad, size_of_quad)



end