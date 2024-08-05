PaddleSelectState = Class {__includes = BaseState}

function PaddleSelectState:enter()
    -- Middle sized paddle by default.
    self.selected_paddle = 1
end

function PaddleSelectState:update(dt)
    if love.keyboard.wasPressed("return") then
        gSounds["confirm"]:play()
        gPaddle.skin = self.selected_paddle
        gStateMachine:change("serve", {is_new_level = true})
    end
    if love.keyboard.wasPressed("left") then
        if self.selected_paddle == 1 then
            gSounds["no-select"]:play()
        else
            self.selected_paddle = self.selected_paddle - 1
            gSounds["select"]:play()
        end
    elseif love.keyboard.wasPressed("right") then
        if self.selected_paddle == N_PADDLE_COLORS then
            gSounds["no-select"]:play()
        else
            self.selected_paddle = self.selected_paddle + 1
            gSounds["select"]:play()
        end
    end
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function PaddleSelectState:render()
    if self.selected_paddle == 1 then
        -- If no more paddles left in the left direction, the arrow should be darkened.
        love.graphics.setColor(40 / 255, 40 / 255, 40 / 255, 128 / 255)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.draw(
        gTextures["arrows"],
        gFrames["arrows"][1],
        VIRTUAL_WIDTH / 2 - gPaddle.width / 2 - SPRITE_SIZE.ARROW - 20,
        2 * VIRTUAL_HEIGHT / 3
    )
    if self.selected_paddle == N_PADDLE_COLORS then
        -- If no more paddles left in the right direction, the arrow should be darkened.
        love.graphics.setColor(40 / 255, 40 / 255, 40 / 255, 128 / 255)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.draw(
        gTextures["arrows"],
        gFrames["arrows"][2],
        VIRTUAL_WIDTH / 2 + gPaddle.width / 2 + 20,
        2 * VIRTUAL_HEIGHT / 3
    )
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(
        gTextures["main"],
        -- There are 4 different sizes of paddles, so the step should be 4 to pick the paddle with different color.
        gFrames["paddles"][gPaddle.size + 4 * (self.selected_paddle - 1)],
        VIRTUAL_WIDTH / 2 - gPaddle.width / 2,
        2 * VIRTUAL_HEIGHT / 3
    )
end
