Player = {}
Player.__index = Player

function Player:Create()
  local newPlayer = {
    key,
    x = 0,
    y = 0,
    trail = {
    }
  }
  setmetatable(newPlayer, self)
  return newPlayer
end

function Player:Draw()
  lg.setColor(colors.red)
  lg.circle("fill", self.x * u, self.y * u, u/4, 50)

  -- draw trail
  local trailXY = {0, 0, 0, 0}
  for index, value in ipairs(self.trail) do
    table.insert(trailXY, value.x * u)
    table.insert(trailXY, value.y * u)
  end
  lg.setLineWidth(u/10)
  lg.line(trailXY)
end

function Player:UpdateTrail()
  for index, value in ipairs(self.trail) do
    if value.t < gameTime - 1 then
      table.remove(self.trail, index)
    end
  end
end