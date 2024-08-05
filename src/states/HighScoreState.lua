HighScoreState = Class {__includes = BaseState}

function HighScoreState:enter()
    self.scores = {}
    local counter = 1
    for line in love.filesystem.lines("scores.csv") do
        self.scores[counter] = {}
        self.scores[counter].player_name = string.sub(line, 1, 3)
        self.scores[counter].game_score = string.sub(line, 5)
        counter = counter + 1
    end
    -- Skip CSB header.
    self.scores = table.slice(self.scores, 2)
end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("start")
    end
end

function HighScoreState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf("High Scores", 0, 10, VIRTUAL_WIDTH, "center")
    love.graphics.setFont(gFonts["medium"])
    for k, score in pairs(self.scores) do
        love.graphics.printf(
            tostring(k) .. ".",
            VIRTUAL_WIDTH / 4,
            60 + k * 13,
            50,
            "left"
        )
        love.graphics.printf(
            score.player_name,
            VIRTUAL_WIDTH / 4 + 38,
            60 + k * 13,
            50,
            "right"
        )
        love.graphics.printf(
            tostring(score.game_score),
            VIRTUAL_WIDTH / 2,
            60 + k * 13,
            100,
            "right"
        )
    end
end
