Ball = Class {}

function Ball:init()
    self.width = SPRITE_SIZE.BALL
    self.height = SPRITE_SIZE.BALL
    self.hit_offset = 2
    -- Change in velocity after brick collision.
    self.collision_velocity_gain = 1.02
    self.dx = 0
    self.dy = 0
    self.skin = 1
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    if self.x <= 0 then
        self.dx = -self.dx
        self.x = 1
        gSounds["wall-hit"]:play()
    elseif self.x >= VIRTUAL_WIDTH - self.width then
        self.dx = -self.dx
        self.x = VIRTUAL_WIDTH - self.width - 1
        gSounds["wall-hit"]:play()
    end
    if self.y <= 0 then
        self.dy = -self.dy
        self.y = 1
        gSounds["wall-hit"]:play()
    end
end

function Ball:render()
    love.graphics.draw(gTextures["main"], gFrames["balls"][self.skin],
                       self.x, self.y)
end

function Ball:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end
    return true
end
