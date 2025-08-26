-- declare global variables here. this block gets executed as soon as the game loads
function love.load()
	target = {} -- table we will refer too
	target.x = 300
	target.y = 300
	target.radius = 50

	score = 0
	timer = 0
	GameState = 1

	gameFont = love.graphics.newFont(40)

	Sprites = {}
	Sprites.sky = love.graphics.newImage("sprites/sky.png")
	Sprites.target = love.graphics.newImage("sprites/target.png")
	Sprites.crosshairs = love.graphics.newImage("sprites/crosshairs.png")

	love.mouse.setVisible(false)
end

-- we can update and alter the variable in the update function
function love.update(dt)
	if timer > 0 then
		timer = timer - dt
	end

	if timer < 0 then
		timer = 0
		GameState = 1
	end
end -- dt stands for delta time

-- we then draw the variable on the screen
function love.draw()
	love.graphics.draw(Sprites.sky, 0, 0)

	love.graphics.setColor(1, 1, 1)
	love.graphics.setFont(gameFont)
	love.graphics.print("Score: " .. score, 5, 5)
	love.graphics.print("Time: " .. math.ceil(timer), 300, 5)

	if GameState == 1 then
		love.graphics.printf("Click to begin!", 0, 250, love.graphics.getWidth(), "center")
	end

	if GameState == 2 then
		love.graphics.draw(Sprites.target, target.x - target.radius, target.y - target.radius)
	end
	love.graphics.draw(Sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)
end

function love.mousepressed(x, y, button, istouch, presses)
	if button == 1 and GameState == 2 then
		local mouseToTarget = distanceBetween(x, y, target.x, target.y)
		if mouseToTarget < target.radius then
			score = score + 1
			target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
			target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
		elseif mouseToTarget > target.radius then
			score = score - 1
			target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
			target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
		end
	elseif button == 1 and GameState == 1 then
		GameState = 2
		timer = 10
		score = 0
	end
end

function distanceBetween(x1, y1, x2, y2)
	return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
