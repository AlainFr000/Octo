# Octo
#### Video Demo: https://www.youtube.com/watch?v=-ZPVl4Vspiw
#### Description:

Project for CS50X final project :
A 2D survival game done with Löve in lua.

The goal is to avoid contact with the continuously spawning ennemies.
You will generate score for each second alive and each enemy killed.
To move, please use arrow keys.
You may fire projectiles at them to try to kill them with spacebar !

Keep trying to improve your score and register it as the best score of the session !

### Tools:
Projet done with
- GIT
- Lua
- Löve
- https://ninjikin.itch.io/starter-tiles & https://ninjikin.itch.io/grass?download for ressources sprites for the map
- https://craftpix.net/download/69845/ & https://craftpix.net/download/74911/ for character and enemies sprites
- https://bdragon1727.itch.io/fire-pixel-bullet-16x16/download/eyJleHBpcmVzIjoxNzUxOTA5NzM5LCJpZCI6OTQxMTM5fQ%3d%3d.ZVaQkv3YTjv8F2HGXHeBm%2fnkh%2fc%3d for projectile sprites

### Design choices:

To begin with, every used sprites maps (or ones that may be used in future improvement) are stored under graphics with a specific folder for each object (more on that under).
Every "component" of the game has been designed as a pseudo-objet, for specific methods and abstraction of repetead steps.

**main.lua**: Main file has the classic love2D architecture with love.load(), love.update() and love.draw() functions.
Each of them calling the objects functions which are handling the logic.

**util.lua**: Utilitary file containing the function that generate a list of quad based on a source, and the size of the sprites on the sheet.
This function is used the drawing of every object.

**mapObject.lua**: contains the map object. It contains the map characteristics and related functions.
There are some randomness for the map type based on the moment of the day.
Map is generated procedurally and randomly, with tiles containing random map sprites (struct tiles) and decoration sprites (addi tiles)
This file also contains function to append the map based on the direction of the player, and therefore multiple if conditions to generate either a line or column.

**playerObject.lua**: contains the player object. It contains the player characteristics and related functions.
Player sprites are loaded, with 2 movement, idle and runing, as well as a state corresponding to death.
This files contains the update logic for the player, that itself call the update logic for the map, ennemies and projectiles.
When player approach the side of the map, he is no more "moving" but instead the map is moved by one line or column, by passing the direction and if update is needed to the appending function of the map. 
Movement can be made in 8 direction (up, down, left, right and combination)
Then at the end, the ennemies and projectiles updates are launched from this function.

**enemyObject.lua**: contains the ennemy object. It contains the ennemies characteristics and related functions.
Ennemies are spawned randomly arround the map borders, with random sprite.
There is a function that spawns ennemies based on a timer.
Also, the update function of each enemy trace a direction vector to the player, and displace itself on this vector based on speed. also, if a collision is detected, then player status change to dead.

**projectileObject.lua**: contains the projectil object. It contains the projectile characteristics and related functions.
The projectile color is randomly selected, with the direction beeing the direction of the player at the moment of the creation.
The position of the projectile is then updated and if colision with an ennemy is detected, they are both sent to a very far place.
I tried the .remove() method but it was creating random crash, certainly due to the multiple iterations.
This might not be the best method but it is the one that works.