Key = {}
Key.__index = Key

function Key:Create(name, x, y, width)
  local newKey = {
    name = name,
    -- all in measurered in units of u (standard size of one keycap)
    x = x + (lg.getWidth()/u - 15)/2,
    y = y + (lg.getHeight()/u - 5)/2,
    w = width
  }
  setmetatable(newKey, self)
  return newKey
end

function Key:Draw()
  lg.setColor(colors.black)
  -- highlight if it is a control key for a player
  for index, value in ipairs(players) do
    if self.name == value.ctrlKey then
      lg.setColor(value.color)
    end
  end
  lg.rectangle("line", (self.x+0.05)*u, (self.y+0.05)*u, (self.w-0.1)*u, 0.9*u, u/4, u/4)
  lg.setFont(font)
  lg.printf(self.name, (self.x+0.05)*u, (self.y+0.05)*u, (self.w-0.1)*u, "center")
end