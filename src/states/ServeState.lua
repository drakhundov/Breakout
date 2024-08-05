ServeState = Class {__includes = BaseState}

function ServeState:enter(params)
    self.is_new_level = params.is_new_level
    gBall.skin = math.random(N_BALL_COLORS)
    gBall.y = gPaddle.y - SPRITE_SIZE.BALL * 3
end

function ServeState:update(dt)
    gPaddle:update(dt)
    -- Keep the ball above the paddle.
    gBall.x = gPaddle.x + gPaddle.width / 2 - SPRITE_SIZE.BALL / 2
    if love.keyboard.wasPressed("space") or love.keyboard.wasPressed("return") then
        gStateMachine:change("play")
    end
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function ServeState:render()
    gPaddle:render()
    gBall:render()
    for k, brick in pairs(gBricks) do
        brick:render(dt)
    end
    renderHealth(gHealth)
    renderScore(gScore)
    -- If ball's fallen below the "ground", a level label shouldn't be displayed during the next try.
    if self.is_new_level then
        love.graphics.setFont(gFonts["large"])
        love.graphics.printf(
            "Level " .. tonumber(gLevel),
            0,
            VIRTUAL_HEIGHT / 2 - 25,
            VIRTUAL_WIDTH,
            "center"
        )
    end
    love.graphics.setFont(gFonts["medium"])
    love.graphics.printf(
        "Press Enter Or Space",
        0,
        VIRTUAL_HEIGHT / 2 + (self.is_new_level and 15 or -15),
        VIRTUAL_WIDTH,
        "center"
    )
end
