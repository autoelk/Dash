Player = {}
Player.__index = Player

function Player:Create(color, pos)
  local newPlayer = {
    points = 0,
    color = color,
    pos = pos,
    word
  }
  setmetatable(newPlayer, self)
  return newPlayer
end

function Player:GenWord()
  self.word = dict[math.random(1, #dict)]
end

function Player:CheckWord(scancode)
  if scancode == self.word:sub(1, 1) then
    self.word = self.word:sub(2)
  end
end

function Player:Draw()
  lg.setColor(self.color)
  lg.printf(self.word, u, u, lg.getWidth()-2*u, self.pos)
  lg.printf(self.points, u, 1.5*u, lg.getWidth()-2*u, self.pos)
end