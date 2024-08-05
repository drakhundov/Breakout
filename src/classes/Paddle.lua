Paddle = Class {}

function Paddle:init()
    self.width = SPRITE_SIZE.PADDLE[2].X
    self.height = SPRITE_SIZE.PADDLE.Y
    self.x = VIRTUAL_WIDTH/2 - self.width/2
    self.y = VIRTUAL_HEIGHT - 32
    self.speed = 200
    self.dx = 0
    self.skin = 1
    self.size = 2
end

function Paddle:update(dt)
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        self.dx = -self.speed
    elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        self.dx = self.speed
    else
        self.dx = 0
    end
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else -- self.dx >= 0
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Paddle:render()
    love.graphics.draw(
        gTextures["main"],
        gFrames["paddles"][self.size + 4 * (self.skin - 1)],
        self.x,
        self.y
    )
end

function Paddle:new_size(size)
    self.size = size
    self.width = SPRITE_SIZE.PADDLE[size].X
end
