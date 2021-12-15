Player = {}
Player.__index = Player

function Player:Create()
  local newPlayer = {
    key,
    x = 0,
    y = 0,
    trail = {}
  }
  setmetatable(newPlayer, self)
  return newPlayer
end

function Player:Draw()
  lg.setColor(colors.red)
  lg.circle("fill", self.x * u, self.y * u, u/4, 50)

  -- draw trail
  local lastX
  local lastY
  for index, value in ipairs(self.trail) do
    if index ~= 1 then
      lg.setLineWidth(u*index/100) -- trails get smaller the older they are
      lg.line(lastX, lastY, value.x * u, value.y * u)
    end
    lastX = value.x * u
    lastY = value.y * u

    if value.t == -1 then
      value.t = gameTime -- start timing how long the trail has been around
    end
  end
  lg.setLineWidth(u/20)
end

function Player:UpdateTrail()
  for index, value in ipairs(self.trail) do
    if value.t < gameTime - 1 and value.t ~= -1 then
      table.remove(self.trail, index)
    end
  end
end