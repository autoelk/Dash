Player = {}
Player.__index = Player

function Player:Create(color)
  local newPlayer = {
    key,
    x = 0,
    y = 0,
    color = color,
    trail = {}
  }
  setmetatable(newPlayer, self)
  return newPlayer
end

function Player:Move(key)
  self.key = key.name
  self.x = key.x + key.w/2
  self.y = key.y + 1/2
  table.insert(self.trail, {x = self.x, y = self.y})

  -- make sure the trail is only 3 segments long
  if #self.trail > 4 then
    table.remove(self.trail, 1)
  end
end

function Player:Draw()
  lg.setColor(self.color)
  lg.circle("fill", self.x*u, self.y*u, u/6, 50)

  -- draw trail
  local lastX
  local lastY
  for i, point in ipairs(self.trail) do
    if i ~= 1 then
      lg.setLineWidth(u*math.log(i + 1)/10) -- trails get smaller the older they are
      lg.line(lastX*u, lastY*u, point.x*u, point.y*u)
    end
    lastX = point.x
    lastY = point.y
  end
  lg.setLineWidth(u/20)
end
