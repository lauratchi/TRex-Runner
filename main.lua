local bump = require 'bump'
local gamestate = require 'gamestate'

require "trex"
require "obstacle"

-- States
local menu = {}
local game = {}

function love.load()
	gamestate.registerEvents()
	gamestate.switch(menu)
end


--------------------- MENU ---------------------
------------------------------------------------

function menu: draw()
	love.graphics.print("Press Enter to continue")
end

function menu: keyreleased(key, code)
	if key == 'return' then
		gamestate.switch(game)
	end
end


--------------------- GAME ---------------------
------------------------------------------------

-- World creation
local world = bump.newWorld()

-- Blocks map
local blocks = {}

function addBlock(x, y, w, h)
	local block = { x = x, y = y, w = w, h = h }
	blocks[#blocks + 1] = block
	world: add(block, x, y, w, h)
end

function drawBlocks()
	for _, block in ipairs(blocks) do
		drawBox(block, 0, 255, 0)
	end
end


------------------------------------------------
local trex = {}
local obstacle = {}
local background = {}

function game: init()

	trex = TRex(world, love.graphics.newImage('media/trex.png'), 100, love.graphics.getHeight() - 100)
	obstacle = Obstacle(world)
	background = love.graphics.newImage('media/background.png')

	--addBlock(0, 0, 640, 32)
	--addBlock(0, 32, 32, 480 - 32*2)
	--addBlock(640 - 32, 32, 32, 480 - 32*2)
	addBlock(0, love.graphics.getHeight() - 32, love.graphics.getWidth(), 32)

end

function game: update(dt)
	trex: update(dt)
	obstacle: update(dt)
end

function game: draw()
	love.graphics.draw(background, 0, 0)
	trex: draw()
	obstacle: draw()
	--drawBlocks()
end

function game: keypressed(key)
    if key == "escape" then
       love.event.quit()
    end
end

function drawBox(box, r, g, b)
	love.graphics.setColor(r, g, b, 70)
	love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
	love.graphics.setColor(r, g, b)
	love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end