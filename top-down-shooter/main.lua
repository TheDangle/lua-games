function love.load()
	-- loading sprite images
	Sprites = {}
	Sprites.background = love.graphics.newImage("sprites/background.png")
	Sprites.bullet = love.graphics.newImage("sprites/bullet.png")
	Sprites.player = love.graphics.newImage("sprites/player.png")
	Sprites.zombie = love.graphics.newImage("sprites/zombie.png")

	Player = {}
	Player.x = love.graphics.getWidth() / 2
	Player.y = love.graphics.getHeight() / 2
	Player.speed = 180

	Zombies = {}
end

function love.update(dt)
	-- player movement
	if love.keyboard.isDown("d") then
		Player.x = Player.x + Player.speed * dt
	end
	if love.keyboard.isDown("a") then
		Player.x = Player.x - Player.speed * dt
	end
	if love.keyboard.isDown("w") then
		Player.y = Player.y - Player.speed * dt
	end
	if love.keyboard.isDown("s") then
		Player.y = Player.y + Player.speed * dt
	end
end

function love.draw()
	-- background
	love.graphics.draw(Sprites.background, 0, 0)
	-- draw player
	love.graphics.draw(
		Sprites.player,
		Player.x,
		Player.y,
		PlayerMouseAngle(),
		nil,
		nil,
		Sprites.player:getWidth() / 2,
		Sprites.player:getHeight() / 2
	)

	-- loop in zombies table and draw zombies
	for i, z in ipairs(Zombies) do
		love.graphics.draw(Sprites.zombie, z.x, z.y)
	end
end

function love.keypressed(key)
	if key == "space" then
		SpawnZombie()
	end
end

-- this function fixes the players look angle to the mouse's position
function PlayerMouseAngle()
	return math.atan2(Player.y - love.mouse.getY(), Player.x - love.mouse.getX()) + math.pi
end

-- function to spawn zombies
function SpawnZombie()
	local zombie = {}
	zombie.x = math.random(0, love.graphics.getWidth())
	zombie.y = math.random(0, love.graphics.getHeight())
	zombie.speed = 100
	table.insert(Zombies, zombie)
end
