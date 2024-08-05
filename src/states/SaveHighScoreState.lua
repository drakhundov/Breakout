SaveHighScoreState = Class {__includes = BaseState}

function SaveHighScoreState:enter()
    self.chars = {
        [1] = 65,
        [2] = 65,
        [3] = 65
    }
    self.current_char = 1
    self.font_size = 32
    self.indent = self.font_size + 5
end

function SaveHighScoreState:update(dt)
    if love.keyboard.wasPressed("return") then
        local name = string.char(self.chars[1]) .. string.char(self.chars[2]) .. string.char(self.chars[3])
        if not love.filesystem.getInfo("scores.csv") then
            love.filesystem.write("scores.csv", "name,score\n")
        end
        love.filesystem.append("scores.csv", name .. "," .. tostring(gScore) .. "\n")
        gStateMachine:change("high-score")
    end
    if love.keyboard.wasPressed("left") and self.current_char > 1 then
        self.current_char = self.current_char - 1
        gSounds["select"]:play()
    elseif love.keyboard.wasPressed("right") and self.current_char < 3 then
        self.current_char = self.current_char + 1
        gSounds["select"]:play()
    end
    if love.keyboard.wasPressed("up") then
        gSounds["pause"]:play()
        self.chars[self.current_char] = self.chars[self.current_char] + 1
        if self.chars[self.current_char] > 90 then
            self.chars[self.current_char] = 65
        end
    elseif love.keyboard.wasPressed("down") then
        gSounds["pause"]:play()
        self.chars[self.current_char] = self.chars[self.current_char] - 1
        if self.chars[self.current_char] < 65 then
            self.chars[self.current_char] = 90
        end
    end
end

function SaveHighScoreState:render()
    love.graphics.setFont(gFonts["medium"])
    love.graphics.printf(
        "Your Score: " .. tostring(gScore),
        0,
        15,
        VIRTUAL_WIDTH,
        "center"
    )
    local MARGIN = (VIRTUAL_WIDTH - self.indent * 3) / 2
    love.graphics.setFont(gFonts["large"])
    for k, char in pairs(self.chars) do
        if self.current_char == k then
            love.graphics.setColor(103 / 255, 1, 1, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        love.graphics.print(
            string.char(char),
            MARGIN + self.indent * (k - 1),
            VIRTUAL_HEIGHT / 2
        )
    end
end
