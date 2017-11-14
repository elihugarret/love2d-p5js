-- -*- Mode: lua; tab-width: 2; lua-indent-level: 2; indent-tabs-mode: nil; -*-
----------------------------------------------------------
-- Based on: https://www.openprocessing.org/sketch/152169
----------------------------------------------------------
local utils = require "p5utils"
local vector = require "hump.vector"

local app = {}

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local twopi = math.pi * 2

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


local g, bs, a

g = .06
-------------
-- Body Class
-------------
local Body = {}
Body.__index = Body

function Body:new(m, p)
  local mt = {
    m = m,
    p = p,
    q = p,
    s = vector.new(0, 0)
  }
  return setmetatable(mt, Body)
end

function Body:update()
  self.s = self.s * 0.98
  self.p = self.p + self.s
end

function Body:attract(b)
  local d = utils.constrain((self.p - b.p):len(), 10, 100)
  local f = (b.p - self.p) * (b.m * self.m * g / (d * d))
  local a = f / self.m
  self.s = self.s + a
end

function Body:show()
  love.graphics.line(self.p.x, self.p.y, self.q.y, self.q.x)
  q = p
end

-- callbacks

function app.load()
  love.window.setMode(800, 600, {resizable=true})
  app.reload()
end

function app.reload()
  bs = {}
  love.graphics.setBackgroundColor(0, 0, 0)
  for i = 1, 999 do
    bs[i] = Body:new(100, vector.new(math.random(width), math.random(height)))
  end
  -- reload by lovelive
end


function app.update(dt) end

function app.draw()
  love.graphics.clear(love.graphics.getBackgroundColor())
  love.graphics.setColor(255, 255, 250, 20)
  a = Body:new(1000, vector.new(math.random(width), math.random(height)))
  for b = 1, 999 do
    bs[b]:show()
    bs[b]:attract(a)
    bs[b]:update()
  end
end

return app
