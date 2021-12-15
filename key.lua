Key = {}
Key.__index = Key

function Key:Create(name, x, y, width)
  local newKey = {
    name = name,
    -- all in measurered in units of u (standard size of one keycap)
    x = x,
    y = y,
    w = width
  }
  setmetatable(newKey, self)
  return newKey
end

function Key:Draw()
  lg.rectangle("line", self.x * u, self.y * u, self.w * u, u)
  lg.printf(self.name, self.x * u, self.y * u, self.w * u, "center")
end