GameOverState = Class {__includes = BaseState}

function GameOverState:update(dt)
    if love.keyboard.wasPressed("return") then
        gStateMachine:change("save-high-score")
    elseif love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf(
        "GAME OVER",
        0,
        VIRTUAL_HEIGHT / 2 - 50,
        VIRTUAL_WIDTH,
        "center"
    )
    love.graphics.setFont(gFonts["medium"])
    love.graphics.printf(
        "Score: " .. tostring(gScore),
        0,
        VIRTUAL_HEIGHT / 2 - 20,
        VIRTUAL_WIDTH,
        "center"
    )
    love.graphics.printf(
        "Levels: " .. tostring(gLevel),
        0,
        VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH,
        "center"
    )
end
