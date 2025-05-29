-- Initialisation

require 'map'
require 'character'
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
local map_position = {x = 0, y = 0}


-- character variable initialisation
local player = Character
local size_of_quad_character = 64
local player_sprites = {}
local player_source_idle = "graphics/character/Unarmed_Idle/Unarmed_Idle_full.png"
local player_source_run = "graphics/character/Unarmed_Run/Unarmed_Run_full.png"


function love.load()
    -- map initialisation
    fullsheet = love.graphics.newImage("graphics/map/GRASS+.png")
    tiles = GenerateSprite(map_source, size_of_quad, size_of_quad)
    mapCanvas = love.graphics.newCanvas(width, height)
    love.graphics.setCanvas(mapCanvas)  
    Draw_map(fullsheet, tiles, width, height, size_of_quad)
    love.graphics.setCanvas()
    -- character init
    player_sprites = {love.graphics.newImage(player_source_idle), love.graphics.newImage(player_source_run)}
    player = Create_character("player", player_source_idle, player_source_run, size_of_quad_character)

end

function love.update(dt) -- used to update the variable


end

function love.draw() -- used to refresh the graphics based on the variable
    -- Draw the image of the map
    love.graphics.draw(mapCanvas, 0, 0, 0, 2, 2)
    -- Draw the player character
    love.graphics.draw(player_sprites[1], player.current_quad, player.position.x, player.position.y, 0, 2, 2)

end

