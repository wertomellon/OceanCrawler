local screen = {}
screen.width = 1280
screen.height = 720
screen.halfWidth = screen.width / 2
screen.halfHeight = screen.height / 2
success = love.window.setMode(screen.width, screen.height, {fullscreen = true})


require 'TestPlayer'
require 'Map'


map = Map:new(25, 15, 64)
map:fill()


PLAYER_START_WIDTH = 64
PLAYER_START_HEIGHT = 64
--PLAYER_START_X = (screen.halfWidth - (PLAYER_START_WIDTH / 2))
--PLAYER_START_Y = (screen.halfHeight - (PLAYER_START_HEIGHT / 2))
PLAYER_START_X = map:getHalfWidth()
PLAYER_START_Y = map:getHalfHeight()

player = TestPlayer:new(PLAYER_START_X, PLAYER_START_Y, 64, 64, 35)

cameraScrollX = 0
cameraScrollY = 0
collisionbool = false


function love.load()





end


function love.update(dt)

if love.keyboard.isDown('escape') then
  love.event.quit()
end


--This block of code checks to see if the player is moving up or down. The player is moved incrementally. BEFORE the players Y position updates it is saved in the event of a collision. When a collision occurs the players Y position is set to the Y position before the collision occured.
if love.keyboard.isDown('w') or love.keyboard.isDown('s') then
  for i = 1, 5 do
    player.oldY = player.y
    player:upDown(dt)
      if map:collision(player) then
        player.y = player.oldY
    end
  end
end
  
--This block of code checks to see if the player is moving left or right. The player is moved incrementally. BEFORE the players X position updates it is saved in the event of a collision. When a collision occurs the players X position is set to the X position before the collision occured.  
if love.keyboard.isDown('a') or love.keyboard.isDown('d') then
  for i = 1, 5 do
    player.oldX = player.x
    player:leftRight(dt)
      if map:collision(player) then
        player.x = player.oldX
    end
  end
end



player:bounds(map:getSize())

if player.x <= map:getRightBound() and player.x >= map:getLeftBound() then
cameraScrollX = player.x - screen.halfWidth + (player.width / 2)
end

if player.y <= map:getDownBound() and player.y >= map:getUpBound() then
cameraScrollY = player.y - screen.halfHeight + (player.height / 2)
end
collisionbool = map:collision(player)

end

function love.draw()
if collisionbool then 
  love.graphics.setColor(1, 0, 0, 1)
else 
  love.graphics.setColor(1, 1, 1, 1)
end




   love.graphics.translate(-cameraScrollX, -cameraScrollY)

 
 
  map:render()
love.graphics.print(player.x, 0, 0)
love.graphics.print(player.y, 0, 50)
  player:render()
end
