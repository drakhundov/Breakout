Brick = Class {}

PALETTECOLORS = {
    -- Blue.
    [1] = {99, 155, 255},
    -- Green.
    [2] = {106, 190, 47},
    -- Red.
    [3] = {217, 87, 99},
    -- Purple.
    [4] = {215, 123, 186},
    -- Gold.
    [5] = {251, 242, 54}
}

function Brick:init(x, y)
    self.width = SPRITE_SIZE.BRICK.X
    self.height = SPRITE_SIZE.BRICK.Y
    self.tier = 1
    self.color = 1
    self.x = x
    self.y = y
    self.explosion = love.graphics.newParticleSystem(gTextures["particle"], 64)
    self.explosion:setParticleLifetime(0.5, 1)
    self.explosion:setLinearAcceleration(-15, 0, 15, 80)
    self.explosion:setEmissionArea("normal", 10, 10)
    self.inPlay = true
end

function Brick:update(dt)
    self.explosion:update(dt)
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(
            gTextures["main"],
            gFrames["bricks"][self.tier + 4 * (self.color - 1)],
            self.x,
            self.y
        )
    end
end

function Brick:hit()
    gSounds["brick-hit-2"]:stop()
    gSounds["brick-hit-2"]:play()
    self.explosion:setColors(
        PALETTECOLORS[self.color][1] / 255,
        PALETTECOLORS[self.color][2] / 255,
        PALETTECOLORS[self.color][3] / 255,
        55 * (self.tier + 1) / 255,
        PALETTECOLORS[self.color][1] / 255,
        PALETTECOLORS[self.color][2] / 255,
        PALETTECOLORS[self.color][3] / 255,
        0
    )
    self.explosion:emit(64)
    if self.tier > 1 then
        self.tier = self.tier - 1
    else
        self.inPlay = false
        gSounds["brick-hit-1"]:stop()
        gSounds["brick-hit-1"]:play()
    end
end

--[[
    Need a separate render function for our particles so it can be called after all bricks are drawn;
    otherwise, some bricks would render over other bricks' particle systems.
]]
function Brick:renderExplosion()
    love.graphics.draw(
        self.explosion,
        self.x + self.width / 2,
        self.y + self.height / 2
    )
end
