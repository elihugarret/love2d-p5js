-- -*- Mode: lua; tab-width: 2; lua-indent-level: 2; indent-tabs-mode: nil; -*-

local utils = require "p5utils"
local vector = require "hump.vector"

local app = {}

width = love.graphics.getWidth()
height = love.graphics.getHeight()

-- config
function app.liveconf(t)
  t.live = true
  t.use_pcall = true
  t.autoreload.enable = false
  t.autoreload.interval = 1.0
  t.reloadkey = "f5"
  t.gc_before_reload = false
  t.error_file = nil  -- "error.txt"
end


-------------------
-- Star Class
-------------------
local Star = {}
Star.__index = Star

function Star:new()
  local mt = {
    a = math.random(5 * (math.pi * 2)),
    r = math.random(width * 0.2, width * 0.25),
    speed = vector.new(math.random() * math.pi * 2, math.random() * math.pi * 2),
    bam = true,
    m = true
  }
  mt.loc = vector.new(width / 2 + math.sin(mt.a) * mt.r, height / 2 + math.cos(mt.a) * mt.r)
  return setmetatable(mt, Star)
end

function Star:update()
  self.bam = vector.new(math.random() * math.pi * 2, math.random() * math.pi * 2)
  self.bam = self.bam * 0.45
  self.speed = self.speed + self.bam
  self.m = utils.constrain(utils.map(utils.dist{self.loc.x, self.loc.y, love.mouse.getX(), love.mouse.getY()}, 0, width, 8, 0.05), 0.05, 8)
  self.speed = self.speed:normalizeInplace() * self.m
  if utils.dist{self.loc.x, self.lox, width / 2, height / 2} > (width / 2) * 0.98 then
    if self.loc.x < width / 2 then
      self.loc.x = width - self.loc.x - 4
    elseif self.loc.x > width / 2 then
      self.loc.x = width - self.loc.x + 4
    end
    if self.loc.y < height / 2 then
      self.loc.y = width - self.loc.y - 4
    elseif self.loc.y > height / 2 then
      self.loc.y = width - self.loc.y + 4
    end
  end
  self.loc = self.loc + self.speed
  return self
end

-- callbacks
function app.load()
  love.window.setMode(800, 600, {resizable=true})
  app.reload()
end

local constellation = {}
local n, d

function app.reload()
  n = 200
  for i = 1, n do 
    constellation[i] = Star:new()
  end
  love.graphics.setBackgroundColor(0, 0, 0)
  love.graphics.setLineWidth(0.75)
  love.graphics.setColor(255, 255, 255, 120)
  -- reload by lovelive
end

function app.update(dt)
end

function app.draw()
  love.graphics.clear(love.graphics.getBackgroundColor())
  for i =1, #constellation do
    constellation[i]:update()
    for j = 1, #constellation do
      if i > j then
        d = (constellation[i].loc - constellation[j].loc):len()
        if d <= width / 10 then
          love.graphics.line(constellation[i].loc.x, constellation[i].loc.y, constellation[j].loc.x, constellation[j].loc.y)
        end
      end
    end
  end
end

return app
