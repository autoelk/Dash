Player = {}
Player.__index = Player

function Player:Create(color, ctrlKey)
  local newPlayer = {
    key,
    ctrlKey = ctrlKey,
    x = 0,
    y = 0,
    color = color,
    trail = {}
  }
  setmetatable(newPlayer, self)
  return newPlayer
end

function Player:Draw()
  lg.setColor(self.color)
  lg.circle("fill", self.x * u, self.y * u, u/6, 50)

  -- draw trail
  local lastX
  local lastY
  for index, value in ipairs(self.trail) do
    if index ~= 1 then
      lg.setLineWidth(u*math.log(index)/10) -- trails get smaller the older they are
      lg.line(lastX, lastY, value.x * u, value.y * u)
    end
    lastX = value.x * u
    lastY = value.y * u
  end
  lg.setLineWidth(u/20)
end