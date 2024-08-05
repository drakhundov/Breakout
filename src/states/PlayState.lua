PlayState = Class {__includes = BaseState}

function PlayState:enter(params)
    -- If paddle was moving during the serving, the ball will be directed accordingly.
    local dir
    if gPaddle.dx then
        dir = gPaddle.dx > 0 and 1 or -1
    else
        dir = math.random(1) == 0 and -1 or 1
    end
    gBall.dx =
        -- Random magnitude.
        math.random(BALL_SPEED_LIMIT.X.MIN,
                    BALL_SPEED_LIMIT.X.MAX)
        * dir
    gBall.dy = -math.random(
        BALL_SPEED_LIMIT.Y.MIN,
        BALL_SPEED_LIMIT.Y.MAX
    )
    self.paused = false
end

function PlayState:update(dt)
    if love.keyboard.wasPressed("space") then
        self.paused = not self.paused
        gSounds["pause"]:play()
    end
    if gBall:collides(gPaddle) then
        gBall.dy = -gBall.dy
        -- If bal is too low, it will be bounced off downwards.
        -- To avoid that we should raise the ball.
        -- Otherwise, the ball should be raised anyway to avoid infinite collision detections.
        if gBall.y > gPaddle.y + gPaddle.height/2 then
            gBall.y = gPaddle.y + gPaddle.height/2 - gBall.height*2
        else
            -- If (gBall.x > gPaddle.x + gBall.hit_offset)
            -- and (gBall.x < gPaddle.x + gPaddle.width - gBall.hit_offset).
            gBall.y = gPaddle.y - gBall.height
        end
        -- If the paddle was moving during the collision and the ball's hit at the right place, it should be accelerated.
        if gBall.x < gPaddle.x + gPaddle.width / 2 and gPaddle.dx < 0 then
            gBall.dx =
                -BALL_SPEED_LIMIT.X.MIN
                - 8 * (gPaddle.x + gPaddle.width / 2 - gBall.x)
        elseif gBall.x > gPaddle.x + gPaddle.width / 2 and gPaddle.dx > 0 then
            gBall.dx =
                BALL_SPEED_LIMIT.X.MIN
                + 8 * (gBall.x - gPaddle.x - gPaddle.width / 2)
        end
        gSounds["paddle-hit"]:play()
    end
    for k, brick in pairs(gBricks) do
        if brick.inPlay and gBall:collides(brick) then
            brick:hit()
            gScore = gScore + 10 * brick.tier
            if gBall.x + gBall.width + gBall.hit_offset > brick.x and gBall.dx > 0 then
                gBall.dx = -gBall.dx
                gBall.x = brick.x - gBall.width
            elseif gBall.x < brick.x + brick.width and gBall.dx < 0 then
                gBall.dx = -gBall.dx
                gBall.x = brick.x + brick.width
            elseif gBall.y + gBall.height > brick.y and gBall.dy > 0 then
                gBall.dy = -gBall.dy
                gBall.y = brick.y - gBall.height
            else -- gBall.y < brick.y + brick.height and gBall.dy < 0
                gBall.dy = -gBall.dy
                gBall.y = brick.y + brick.height + gBall.height
            end
            gBall.dy = gBall.dy * gBall.collision_velocity_gain
            if checkVictory(gBricks) then
                gSounds["victory"]:play()
                gLevel = gLevel + 1
                gBricks = LevelMaker.createMap(gLevel)
                gStateMachine:change("serve",{is_new_level = true})
            end
        end
    end
    -- If the ball falls below the "ground".
    if gBall.y > VIRTUAL_HEIGHT then
        gSounds["hurt"]:play()
        gHealth = gHealth - 1
        if gHealth > 0 then
            gStateMachine:change("serve", {is_new_level = false})
        else
            gStateMachine:change("game-over")
        end
    end
    gBall:update(dt)
    gPaddle:update(dt)
    for k, brick in pairs(gBricks) do
        brick:update(dt)
    end
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function PlayState:render()
    gPaddle:render()
    gBall:render()
    for k, brick in pairs(gBricks) do
        brick:render()
    end
    for k, brick in pairs(gBricks) do
        brick:renderExplosion()
    end
    if self.paused then
        love.graphics.setFont(gFonts["large"])
        love.graphics.printf(
            "PAUSED",
            0,
            VIRTUAL_HEIGHT / 2,
            VIRTUAL_WIDTH,
            "center"
        )
    end
    renderHealth()
    renderScore()
end

function checkVictory(bricks)
    for k, brick in pairs(bricks) do
        if brick.inPlay then
            return false
        end
    end
    return true
end
