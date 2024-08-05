LevelMaker = Class {}

MODES = {
    "skip",
    "alternate",
    "contiguous"
}

function LevelMaker.createMap(level)
    local bricks = {}
    local maxRows = math.min(level, MAX_ROWS)
    local maxCols = math.min(level + MIN_COLS - 1, MAX_COLS)
    local nRows = math.random(MIN_ROWS, maxRows)
    local nCols = math.random(MIN_COLS, maxCols)
    nCols = nCols % 2 == 0 and (nCols + 1) or nCols
    local highestTier = math.min(level, N_BRICK_TIERS)
    local SPACE_FOR_BRICKS = VIRTUAL_WIDTH - BRICK_WALL_INDENT*2
    -- How much space should be left before and after each brick.
    local LEAVE_SPACE = (SPACE_FOR_BRICKS - SPRITE_SIZE.BRICK.X * nCols) / (nCols-1)
    local nextPosX
    for y = 1, nRows do
        nextPosX = BRICK_WALL_INDENT
        local mode = MODES[math.random(#MODES)]
        local flag = 1
        local color, tier
        local color1, color2, tier1, tier2
        if mode == "alternate" then
            color1 = math.random(N_BRICK_COLORS)
            tier1 = generateTier(highestTier)
            color2 = math.random(N_BRICK_COLORS)
            tier2 = generateTier(highestTier)
        else
            color = math.random(N_BRICK_COLORS)
            tier = generateTier(highestTier)
        end
        for x = 1, nCols do
            if mode == "skip" then
                -- If this paddle should be skipped.
                if flag == 0 then
                    x = x + 1
                    -- Next paddle shouldn't be skipped.
                    flag = 1
                else
                    -- If this paddle will be instantiated, skip next one.
                    flag = 0
                end
            elseif mode == "alternate" then
                color = (flag == 0 and color1 or color2)
                tier = (flag == 0 and tier1 or tier2)
                flag = (flag == 0 and 1 or 0)
            end
            brick = Brick(
                nextPosX,
                10 + y * SPRITE_SIZE.BRICK.Y
            )
            nextPosX = nextPosX + SPRITE_SIZE.BRICK.X + LEAVE_SPACE
            brick.color = color
            brick.tier = tier
            table.insert(bricks, brick)
        end
    end
    return bricks
end

function generateTier(highestTier)
    -- The chance that the lowest tier will be selected is higher.
    if math.random(2) == 1 then
        -- Lowest tier.
        return 1
    else
        return math.random(highestTier)
    end
end
