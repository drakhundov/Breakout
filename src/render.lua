function renderHealth()
    local x = VIRTUAL_WIDTH - 5 - (SPRITE_SIZE.HEART.X + 1) * MAX_HEALTH
    local y = 7
    for i = 1, gHealth do
        love.graphics.draw(gTextures["hearts"], gFrames["hearts"][1], x, y)
        x = x + SPRITE_SIZE.HEART.X + 1
    end
    for i = 1, MAX_HEALTH - gHealth do
        love.graphics.draw(gTextures["hearts"], gFrames["hearts"][2], x, y)
        x = x + SPRITE_SIZE.HEART.X + 1
    end
end

function renderScore()
    love.graphics.setFont(gFonts["small"])
    love.graphics.printf("Score: " .. gScore, 5, 5, VIRTUAL_WIDTH, "left")
end

function displayFPS()
    -- Simple FPS display across all states.
    love.graphics.setFont(gFonts["small"])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 5, 5)
end
