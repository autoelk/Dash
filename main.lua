require "key"
require "player"

lg = love.graphics

keys = {}
colors = {
  red = {250 / 255, 89 / 255, 52 / 255},
  orange = {250 / 255, 121 / 255, 33 / 255},
  yellow = {253 / 255, 231 / 255, 76 / 255},
  green = {155 / 255, 197 / 255, 61 / 255},
  blue = {91 / 255, 192 / 255, 235 / 255},
  grey = {77 / 255, 80 / 255, 87 / 255},
  white = {1, 1, 1},
  black = {0, 0, 0}
}

function love.load()
  math.randomseed(os.time())
  u = math.floor(math.min(lg.getHeight(), lg.getWidth())/10)
  loadKeys()
  font = love.graphics.newFont("assets/ReadexPro-Regular.ttf", u/3)

  players = {}
  players[1] = Player:Create(colors.red, "lctrl")
  players[2] = Player:Create(colors.blue, "rctrl")

  control = 0 -- no one starts with control
end

function love.keypressed(key, scancode, isrepeat)

  for index, value in ipairs(players) do
    if scancode == value.ctrlKey then
      control = index
      
      value.ctrlKey = keys[math.random(1, #keys)].name -- generate new ctrl key
    end
  end

  for index, value in ipairs(keys) do
    if scancode == value.name then
      for i = 1, #players, 1 do
        if control == i then
          players[i].key = scancode
          players[i].x = value.x + value.w/2
          players[i].y = value.y + 1/2
          table.insert(players[i].trail, {name = scancode, x = players[i].x, y = players[i].y})
        end
      end
    end
  end
end

function love.update(dt)    
  for index, value in ipairs(players) do
    while #value.trail > 4 do
      table.remove(value.trail, 1)
    end
  end
end

function love.draw()
  lg.setBackgroundColor(colors.white)

  -- draw keyboard
  for index, value in ipairs(keys) do
    value:Draw()
  end

  -- draw players and trails
  for index, value in ipairs(players) do
    value:Draw()
  end
end

function loadKeys()
  table.insert(keys, Key:Create("`", 0, 0, 1))
  table.insert(keys, Key:Create("1", 1, 0, 1))
  table.insert(keys, Key:Create("2", 2, 0, 1))
  table.insert(keys, Key:Create("3", 3, 0, 1))
  table.insert(keys, Key:Create("4", 4, 0, 1))
  table.insert(keys, Key:Create("5", 5, 0, 1))
  table.insert(keys, Key:Create("6", 6, 0, 1))
  table.insert(keys, Key:Create("7", 7, 0, 1))
  table.insert(keys, Key:Create("8", 8, 0, 1))
  table.insert(keys, Key:Create("9", 9, 0, 1))
  table.insert(keys, Key:Create("0", 10, 0, 1))
  table.insert(keys, Key:Create("-", 11, 0, 1))
  table.insert(keys, Key:Create("=", 12, 0, 1))
  table.insert(keys, Key:Create("backspace", 13, 0, 2))

  table.insert(keys, Key:Create("tab", 0, 1, 1.5))
  table.insert(keys, Key:Create("q", 1.5, 1, 1))
  table.insert(keys, Key:Create("w", 2.5, 1, 1))
  table.insert(keys, Key:Create("e", 3.5, 1, 1))
  table.insert(keys, Key:Create("r", 4.5, 1, 1))
  table.insert(keys, Key:Create("t", 5.5, 1, 1))
  table.insert(keys, Key:Create("y", 6.5, 1, 1))
  table.insert(keys, Key:Create("u", 7.5, 1, 1))
  table.insert(keys, Key:Create("i", 8.5, 1, 1))
  table.insert(keys, Key:Create("o", 9.5, 1, 1))
  table.insert(keys, Key:Create("p", 10.5, 1, 1))
  table.insert(keys, Key:Create("[", 11.5, 1, 1))
  table.insert(keys, Key:Create("]", 12.5, 1, 1))
  table.insert(keys, Key:Create("\\", 13.5, 1, 1.5))

  table.insert(keys, Key:Create("capslock", 0, 2, 1.75))
  table.insert(keys, Key:Create("a", 1.75, 2, 1))
  table.insert(keys, Key:Create("s", 2.75, 2, 1))
  table.insert(keys, Key:Create("d", 3.75, 2, 1))
  table.insert(keys, Key:Create("f", 4.75, 2, 1))
  table.insert(keys, Key:Create("g", 5.75, 2, 1))
  table.insert(keys, Key:Create("h", 6.75, 2, 1))
  table.insert(keys, Key:Create("j", 7.75, 2, 1))
  table.insert(keys, Key:Create("k", 8.75, 2, 1))
  table.insert(keys, Key:Create("l", 9.75, 2, 1))
  table.insert(keys, Key:Create(";", 10.75, 2, 1))
  table.insert(keys, Key:Create("'", 11.75, 2, 1))
  table.insert(keys, Key:Create("return", 12.75, 2, 2.25))

  table.insert(keys, Key:Create("lshift", 0, 3, 2.25))
  table.insert(keys, Key:Create("z", 2.25, 3, 1))
  table.insert(keys, Key:Create("x", 3.25, 3, 1))
  table.insert(keys, Key:Create("c", 4.25, 3, 1))
  table.insert(keys, Key:Create("v", 5.25, 3, 1))
  table.insert(keys, Key:Create("b", 6.25, 3, 1))
  table.insert(keys, Key:Create("n", 7.25, 3, 1))
  table.insert(keys, Key:Create("m", 8.25, 3, 1))
  table.insert(keys, Key:Create(",", 9.25, 3, 1))
  table.insert(keys, Key:Create(".", 10.25, 3, 1))
  table.insert(keys, Key:Create("/", 11.25, 3, 1))
  table.insert(keys, Key:Create("rshift", 12.25, 3, 2.75))

  table.insert(keys, Key:Create("lctrl", 0, 4, 1.25))
  table.insert(keys, Key:Create("lgui", 1.25, 4, 1.25))
  table.insert(keys, Key:Create("lalt", 2.5, 4, 1.25))
  table.insert(keys, Key:Create("space", 3.75, 4, 6.25))
  table.insert(keys, Key:Create("ralt", 10, 4, 1.25))
  -- table.insert(keys, Key:Create("menu", 11.25, 4, 1.25))
  table.insert(keys, Key:Create("application", 12.5, 4, 1.25))
  table.insert(keys, Key:Create("rctrl", 13.75, 4, 1.25))
end