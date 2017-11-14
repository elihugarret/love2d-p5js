-- -*- Mode: lua; tab-width: 2; lua-indent-level: 2; indent-tabs-mode: nil; -*-

local utils = require "p5utils"
local vector = require "hump.vector"

local app = {}

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local t = 0.001
local millis = 0

local function harom(ax, ay, bx, by, level, ratio)
  if level ~= 0 then
    local vx, vy, nx, ny, cx, cy
    vx = bx - ax
    vy = by - ay
    nx = math.cos(math.pi / 3) * vx - math.sin(math.pi / 3) * vy
    ny = math.sin(math.pi / 3) * vx + math.cos(math.pi / 3) * vy
    cx = ax + nx
    cy = ay + ny
    love.graphics.line(ax, ay, bx, by)
    love.graphics.line(ax, ay, cx, cy)
    love.graphics.line(cx, cy, bx, by)
    love.graphics.line(ay, ax, by, bx)
    love.graphics.line(ay, ax, cy, cx)
    love.graphics.line(cy, cx, by, bx)
    harom(ax * ratio + cx * (1 - ratio), 
          ay * ratio + cy * (1 - ratio), 
          ax * (1 - ratio) + bx * ratio, 
          ay * (1 - ratio) + by * ratio,
          level - 1,
          ratio)
  end
end

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

function app.load()
  love.window.setMode(800, 600, {resizable=true})
  app.reload()
end

function app.reload()
  love.graphics.setBackgroundColor(0, 0, 0)
  love.graphics.setLineWidth(1)
end

function app.update(dt) 
  millis = (millis + dt) + 5
end

function app.draw()
  love.graphics.clear(love.graphics.getBackgroundColor())
  harom(height, width, 40, 160, 6, (math.sin(.0005 * millis % (2 * math.pi)) + 1) / 2)
end

return app
