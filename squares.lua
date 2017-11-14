-- -*- Mode: lua; tab-width: 2; lua-indent-level: 2; indent-tabs-mode: nil; -*-

local utils = require "p5utils"
local vector = require "hump.vector"

local app = {}

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local frame = 0

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
  love.graphics.setColor(255, 255, 255, 190)
end

function app.update(dt)
  frame = frame + dt
end

function app.draw()
  love.graphics.clear(love.graphics.getBackgroundColor())
  for x = 10, width - 1, 10 do
    for y = 10, height - 1, 10 do
      local n = love.math.noise(x * 0.005, y * 0.005, frame * 0.5)
      love.graphics.push()
      love.graphics.translate(x, y)
      love.graphics.rotate(math.pi * n)
      love.graphics.scale(10 * n)
      love.graphics.rectangle("line", y, 0, 1, 1)
      love.graphics.pop()
    end
  end
end

return app
