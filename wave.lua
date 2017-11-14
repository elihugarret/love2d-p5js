-- -*- Mode: lua; tab-width: 2; lua-indent-level: 2; indent-tabs-mode: nil; -*-
----------------------------------------------------------
-- Based on: https://www.openprocessing.org/sketch/152169
----------------------------------------------------------
local utils = require "p5utils"

local app = {}

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


-- callbacks

function app.load()
  love.window.setMode(800, 600, {resizable=true})
  app.reload()
end

local step, sz, offSet, angle

local twopi = math.pi * 2

function app.reload()
  num = 20
  step = 15
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  theta = 0
  love.graphics.setBackgroundColor(0, 0, 0)
  love.graphics.setLineWidth(5)
  -- reload by lovelive
end

function app.update(dt)
end

function app.draw()
  love.graphics.clear(love.graphics.getBackgroundColor())
  love.graphics.translate(width / 2, height / 2)
  local angle = 0
  for i = 0, num - 1 do
    love.graphics.setColor(math.random(10,255), math.random(100, 255), 255)
    sz = i * step
    offSet = twopi / num * i
    local arcEnd = utils.map(math.tan(theta + offSet), -1, 1, math.pi, twopi)
    love.graphics.arc("line", "open", 0, 0, sz, arcEnd, math.pi)
  end
  theta = theta + 0.0523
end

return app
