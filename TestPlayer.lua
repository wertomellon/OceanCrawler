local screen = {}
screen.width = 1280
screen.height = 720
screen.halfWidth = screen.width / 2
screen.halfHeight = screen.height / 2



TestPlayer = {}
TestPlayer.__index = TestPlayer
TestPlayer.x = 100
TestPlayer.y = 100
TestPlayer.width = 90
TestPlayer.height = 90
TestPlayer.speed = 200

--Creates a new TestPlayer object
function TestPlayer:new(x, y, width, height, speed)
  local instance = {}
  instance.x = x
  instance.y = y
  instance.width = width
  instance.height = height
  instance.speed = speed
  instance.oldX = x
  instance.oldY = y
  setmetatable(instance, TestPlayer)
  
  return instance
end



--Moves the player up or down
function TestPlayer:upDown(x)
  if love.keyboard.isDown('w') then
    self.y = self. y - self.speed * x
  end
  
  if love.keyboard.isDown('s') then
    self.y = self.y + self.speed * x
  end
end

 
--Moves the player left or right
function TestPlayer:leftRight(x)
   if love.keyboard.isDown('a') then
    self.x = self.x - self.speed * x
  end
   if love.keyboard.isDown('d') then
    self.x = self.x + self.speed * x
   end
end


--bounds function takes Map:getSize() as an argument. The bounds function keeps the player from escaping the playable area but does nothing to keep the camera from going beyond the playable area
function TestPlayer:bounds(mapWidth, mapHeight, mapSize)
  if self.x < 0 then
    self.x = 0
  end
  
  if self.x > (mapWidth * mapSize) - self.width then
    self.x = (mapWidth * mapSize) - self.width
  end
  
  if self.y < 0 then
    self.y = 0
  end
  
  if self.y > (mapHeight * mapSize) - self.height then
    self.y = (mapHeight * mapSize) - self.height
  end
end



--Draws the player to the screen
function TestPlayer:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

  