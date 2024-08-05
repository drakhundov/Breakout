function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight
    local sheetCounter = 1
    local spritesheet = {}
    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end
    return spritesheet
end

function GenerateQuadsPaddles(atlas)
    local x = 0
    local y = 64
    local quads = {}
    local counter = 1
    for i = 0, 3 do
        -- Small.
        quads[counter] = love.graphics.newQuad(
            x,
            y,
            SPRITE_SIZE.PADDLE[1].X,
            SPRITE_SIZE.PADDLE.Y,
            atlas:getDimensions()
        )
        counter = counter + 1
        -- Medium.
        quads[counter] = love.graphics.newQuad(
            x + SPRITE_SIZE.PADDLE[1].X,
            y,
            SPRITE_SIZE.PADDLE[2].X,
            SPRITE_SIZE.PADDLE.Y,
            atlas:getDimensions()
        )
        counter = counter + 1
        -- Large.
        quads[counter] = love.graphics.newQuad(
            x + SPRITE_SIZE.PADDLE[1].X + SPRITE_SIZE.PADDLE[2].X,
            y,
            SPRITE_SIZE.PADDLE[3].X,
            SPRITE_SIZE.PADDLE.Y,
            atlas:getDimensions()
        )
        counter = counter + 1
        -- Huge.
        quads[counter] = love.graphics.newQuad(
            x,
            y + SPRITE_SIZE.PADDLE.Y,
            SPRITE_SIZE.PADDLE[4].X,
            SPRITE_SIZE.PADDLE.Y,
            atlas:getDimensions()
        )
        counter = counter + 1
        -- Prepare Y for the next set of paddles (they will be below the current ones in the file).
        -- One set of paddle sprites are in two rows.
        y = y + SPRITE_SIZE.PADDLE.Y * 2
    end
    return quads
end

function GenerateQuadsBalls(atlas)
    local x = 96
    local y = 48
    local quads = {}
    local counter = 1
    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(
            x,
            y,
            SPRITE_SIZE.BALL,
            SPRITE_SIZE.BALL,
            atlas:getDimensions()
        )
        x = x + SPRITE_SIZE.BALL
        counter = counter + 1
    end
    -- Go to the next row.
    x = 96
    y = y + SPRITE_SIZE.BALL
    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(
            x,
            y,
            SPRITE_SIZE.BALL,
            SPRITE_SIZE.BALL,
            atlas:getDimensions()
        )
        x = x + SPRITE_SIZE.BALL
        counter = counter + 1
    end
    return quads
end

function GenerateQuadsBricks(atlas)
    return table.slice(
        GenerateQuads(
            atlas,
            SPRITE_SIZE.BRICK.X,
            SPRITE_SIZE.BRICK.Y
        ),
        1,
        21
    )
end
