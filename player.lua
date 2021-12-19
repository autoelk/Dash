Player = {}
Player.__index = Player

function Player:Create(color, ctrlKey)
  local newPlayer = {
    key,
    x = 0,
    y = 0,
    color = color,
    ctrlKey = ctrlKey,
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
  -- draw trail
  segments = pointsToSegments(self.trail)
  for i, seg in ipairs(segments) do
    lg.setLineWidth(u*math.log(i + 1)/10) -- trails get smaller the older they are
    lg.circle("fill", seg.x2*u, seg.y2*u, u*math.log(i + 1)/20, 100) -- circles that connect each segment
    lg.line(seg.x1*u, seg.y1*u, seg.x2*u, seg.y2*u)
  end
  lg.setLineWidth(u/20)
end

function Player:CheckIntersect()
  -- loop through each player and their trails to see if the line intersects
  if #self.trail > 1 then
    for i, player in ipairs(players) do
      if self ~= player then
        segments = pointsToSegments(player.trail)
        for j, seg in ipairs(segments) do
          p1 = {x = seg.x1, y = seg.y1}
          q1 = {x = seg.x2, y = seg.y2}
          p2 = {x = self.trail[#self.trail-1].x, y = self.trail[#self.trail-1].y}
          q2 = {x = self.x, y = self.y}
          if intersect(p1, q1, p2, q2) then
            player.color = colors.red
          end
        end
      end
    end
  end
end

function pointsToSegments(points)
  local lastX
  local lastY
  local segments = {}
  for i, point in ipairs(points) do
    if i ~= 1 then
      table.insert(segments, {x1 = lastX, y1 = lastY, x2 = point.x, y2 = point.y})
    end
    lastX = point.x
    lastY = point.y
  end
  return segments
end

-- checks if three points are on the same line
function collinear(p, q, r)
  return q.x <= math.max(p.x, r.x) and q.x >= math.min(p.x, r.x) and q.y <= math.max(p.y, r.y) and q.y >= math.min(p.y, r.y)
end

-- find the orientation of the ordered triplet
function orientation(p, q, r)
  val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)
  if val > 0 then
    return 1 -- clockwise
  elseif val < 0 then
    return 2 -- counterclockwise
  else
    return 0 -- collinear
  end
end

-- checks if two line segments intersect
function intersect(p1, q1, p2, q2)
  -- different orientations for all cases
  o1 = orientation(p1, q1, p2)
  o2 = orientation(p1, q1, q2)
  o3 = orientation(p2, q2, p1)
  o4 = orientation(p2, q2, q1)

  -- general case
  if ((o1 ~= o2) and (o3 ~= o4)) then
    return true
  end

  -- special cases
  if ((o1 == 0) and collinear(p1, p2, q1)) then
    return true
  end
  if ((o2 == 0) and collinear(p1, q2, q1)) then
    return true
  end
  if ((o3 == 0) and collinear(p2, p1, q2)) then
    return true
  end
  if ((o4 == 0) and collinear(p2, q1, q2)) then
    return true
  end
  return false
end