StartState = Class {__includes = BaseState}

function StartState:enter()
    -- Whether game highlites 'Start' or 'High Scores'.
    self.selected_menu_opt = 1
end

function StartState:update(dt)
    if love.keyboard.wasPressed("up") or love.keyboard.wasPressed("down") then
        self.selected_menu_opt =
            (self.selected_menu_opt == 1) and 2 or 1
        gSounds["paddle-hit"]:play()
    end
    if love.keyboard.wasPressed("return") then
        gSounds["confirm"]:play()
        if self.selected_menu_opt == 1 then
            gStateMachine:change("paddle-select")
        else
            gStateMachine:change("high-score")
        end
    end
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function StartState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, "center")
    love.graphics.setFont(gFonts["medium"])
    -- Highlight selected option.
    if self.selected_menu_opt == 1 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.printf(
        "START",
        0,
        VIRTUAL_HEIGHT / 2 + 70,
        VIRTUAL_WIDTH,
        "center"
    )
    if self.selected_menu_opt == 2 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.printf(
        "HIGH SCORES",
        0,
        VIRTUAL_HEIGHT / 2 + 90,
        VIRTUAL_WIDTH,
        "center"
    )
end
