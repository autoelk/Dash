Player = {}
Player.__index = Player

function Player:Create()
  local newPlayer = {
    x = 0,
    y = 0
  }
  setmetatable(newPlayer, self)
  return newPlayer
end

function Player:Draw()
  lg.circle("fill", self.x * u, self.y * u, u / 3, 50)
end