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
  lg.setFont(font)
  lg.rectangle("line", (self.x+0.05)*u, (self.y+0.05)*u, (self.w-0.1)*u, 0.9*u, u/4, u/4)
  lg.printf(self.name, (self.x+0.05)*u, (self.y+0.05)*u, (self.w-0.1)*u, "center")
end