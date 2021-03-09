local screen = {}
screen.width = 1280
screen.height = 720
screen.halfWidth = screen.width / 2
screen.halfHeight = screen.height / 2


Map = {}
Map.__index = Map


spriteSheet = love.graphics.newImage('Testsheet.png')

solidTile = love.graphics.newQuad(0, 0, love.window.fromPixels(64), love.window.fromPixels(64), spriteSheet:getWidth(), spriteSheet:getHeight())
airTile = love.graphics.newQuad(love.window.fromPixels(64), 0, love.window.fromPixels(64), love.window.fromPixels(64), spriteSheet:getWidth(), spriteSheet:getHeight())

--due to the way the camera works if the map is smaller than the screensize then the level will be topleft aligned
MAP_WIDTH = 25 --Minimum width is 20 for a centered screen
MAP_HEIGHT = 15 --Minimun width is 12 for a centered screen
TILE_SIZE = 64
MAP_RIGHTBOUND = TILE_SIZE * (MAP_WIDTH - 10.5)
MAP_DOWNBOUND = TILE_SIZE * (MAP_HEIGHT - 6)
tileTable = {}
airTileID = 1
solidTileID = 2
idTable = {}
quadTable = {}
quadTable[1] = airTile
quadTable[2] = solidTile


function Map:new()
  local instance = {}
  instance.height = MAP_HEIGHT
  instance.width = MAP_WIDTH
  instance.tileSize = TILE_SIZE
  
  setmetatable(instance, Map)
  return instance
end

--Creates a 2d array that is filled with the ID of relevent tiles. NOTE this function does not fill the table with quads rather it fiils the table with a specific ID that corresponds with the index in the quadTable[] 
function Map:fill()
  for y = 1, MAP_HEIGHT do
    table.insert(self, {})
    
      for x = 1, MAP_WIDTH do
        if y < 2 or y > MAP_HEIGHT - 1 then
          table.insert(self[y], solidTileID)
        else if x < 2 or x > MAP_WIDTH - 1 then
          table.insert(self[y], solidTileID)
        else
          table.insert(self[y], airTileID)
      end
    end
  end  
end
end

--Returns information about the map used as the argument to Player:bounds() at the momment
function Map:getWidth()
  return self.width
end

function Map:getHeight()
  return self.height
end

function Map:getTileSize()
  return self.tileSize
end

function Map:getSize()
  return self.width, self.height, self.tileSize
end

function Map:getHalfWidth()
  return ((self.width * self.tileSize) / 2)
end

function Map:getHalfHeight()
  return ((self.height * self.tileSize) / 2)
end

  
function Map:getLeftBound()
  return 608
end

function Map:getRightBound()
  return MAP_RIGHTBOUND
end

function Map:getUpBound()
  return 328
end

function Map:getDownBound()
  return MAP_DOWNBOUND
end


  
  --Takes the array created in Map:fill() and uses the ID numbers to get the corresponding quad in the quadTable. The array created in Map:fill() is self[y][x] in this function. This function is used in love.draw()
function Map:render()
  for y = 1, MAP_HEIGHT do
    for x = 1, MAP_WIDTH do 
      love.graphics.draw(spriteSheet, quadTable[self[y][x]], ((x - 1) * TILE_SIZE), ((y -1) * TILE_SIZE))
    end
  end
end


--This function Checks all 4 corners of the players hitbox and takes their position and converts it into the the corresponding tile in the tile grid. The player bounds function should keep the arrays within their apropriate indexes but returns false if out of the index anyways. self[][] is the tile ID 2d array. 
function Map:collision(entity)
  if entity.x < 0 or entity.x > MAP_WIDTH * TILE_SIZE or entity.y < 0 or entity.y > MAP_HEIGHT * TILE_SIZE then
    return false
  else if entity.y + entity.height > MAP_HEIGHT * TILE_SIZE then
    return false
  else if self[math.floor(((entity.y + 1) / TILE_SIZE) + 1)][math.floor(((entity.x + 1)/ TILE_SIZE) + 1)] == 2 then
    return true
  else if self[math.floor(((entity.y - 1) / TILE_SIZE) + 2)][math.floor(((entity.x - 1) / TILE_SIZE) + 2)] == 2 then
   return true
  else if self[math.floor(((entity.y + 1) / TILE_SIZE) + 1)][math.floor(((entity.x - 1) / TILE_SIZE) + 2)] == 2 then
   return true
   else if self[math.floor(((entity.y - 1) / TILE_SIZE) + 2)][math.floor(((entity.x + 1) / TILE_SIZE) + 1)] == 2 then
   return true
  else 
    return false
            end
          end
        end
      end
    end
  end
end