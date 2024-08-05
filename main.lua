require "src/Dependencies"

DEBUG = {
    showFPS = false
}

-- TODO: Add mouse control to paddle.
-- TODO: Sort scores.
-- TODO: Change paddle size every level.

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Breakout")
    push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WINDOW_WIDTH,
        WINDOW_HEIGHT,
        {
            fullscreen = false,
            resizable = true,
            vsync = true
        }
    )
    gFonts = {
        ["small"] = love.graphics.newFont("assets/font.ttf", 8),
        ["medium"] = love.graphics.newFont("assets/font.ttf", 16),
        ["large"] = love.graphics.newFont("assets/font.ttf", 32)
    }
    -- Credit for graphics (amazing work!):
    -- https://opengameart.org/users/buch
    gTextures = {
        ["background"] = love.graphics.newImage("assets/graphics/background.png"),
        ["main"] = love.graphics.newImage("assets/graphics/breakout.png"),
        ["arrows"] = love.graphics.newImage("assets/graphics/arrows.png"),
        ["hearts"] = love.graphics.newImage("assets/graphics/hearts.png"),
        ["particle"] = love.graphics.newImage("assets/graphics/particle.png")
    }
    backgroundWidth = gTextures["background"]:getWidth()
    bgWidthScaleFactor = VIRTUAL_WIDTH / backgroundWidth
    backgroundHeight = gTextures["background"]:getHeight()
    bgHeightScaleFactor = VIRTUAL_HEIGHT / backgroundHeight
    -- Credit for music (great loop):
    -- http://freesound.org/people/joshuaempyre/sounds/251461/
    -- http://www.soundcloud.com/empyreanma
    gSounds = {
        ["paddle-hit"] = love.audio.newSource("assets/sounds/paddle_hit.wav", "static"),
        ["score"] = love.audio.newSource("assets/sounds/score.wav", "static"),
        ["wall-hit"] = love.audio.newSource("assets/sounds/wall_hit.wav", "static"),
        ["confirm"] = love.audio.newSource("assets/sounds/confirm.wav", "static"),
        ["select"] = love.audio.newSource("assets/sounds/select.wav", "static"),
        ["no-select"] = love.audio.newSource("assets/sounds/no-select.wav", "static"),
        ["brick-hit-1"] = love.audio.newSource("assets/sounds/brick-hit-1.wav", "static"),
        ["brick-hit-2"] = love.audio.newSource("assets/sounds/brick-hit-2.wav", "static"),
        ["hurt"] = love.audio.newSource("assets/sounds/hurt.wav", "static"),
        ["victory"] = love.audio.newSource("assets/sounds/victory.wav", "static"),
        ["recover"] = love.audio.newSource("assets/sounds/recover.wav", "static"),
        ["high-score"] = love.audio.newSource("assets/sounds/high_score.wav", "static"),
        ["pause"] = love.audio.newSource("assets/sounds/pause.wav", "static"),
        ["soundtrack"] = love.audio.newSource("assets/sounds/music.wav", "static")
    }
    gSounds["soundtrack"]:setLooping(true)
    gSounds["soundtrack"]:play()
    gFrames = {
        ["paddles"] = GenerateQuadsPaddles(gTextures["main"]),
        ["balls"] = GenerateQuadsBalls(gTextures["main"]),
        ["bricks"] = GenerateQuadsBricks(gTextures["main"]),
        ["hearts"] = GenerateQuads(
            gTextures["hearts"],
            SPRITE_SIZE.HEART.X,
            SPRITE_SIZE.HEART.Y),
        ["arrows"] = GenerateQuads(
            gTextures["arrows"],
            SPRITE_SIZE.ARROW,
            SPRITE_SIZE.ARROW)
    }
    gStateMachine =
        StateMachine {
        ["start"] = function()
            return StartState()
        end,
        ["play"] = function()
            return PlayState()
        end,
        ["serve"] = function()
            return ServeState()
        end,
        ["game-over"] = function()
            return GameOverState()
        end,
        ["high-score"] = function()
            return HighScoreState()
        end,
        ["save-high-score"] = function()
            return SaveHighScoreState()
        end,
        ["paddle-select"] = function()
            return PaddleSelectState()
        end
    }
    gStateMachine:change("start")
    math.randomseed(os.time())
    love.keyboard.keysPressed = {}
    gPaddle = Paddle()
    gBall = Ball()
    gBricks = LevelMaker.createMap(1)
    gHealth = MAX_HEALTH
    gScore = 0
    gLevel = 1
end

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:apply("start")
    love.graphics.draw(
        gTextures["background"],
        0,
        0,
        0,
        bgWidthScaleFactor,
        bgHeightScaleFactor
    )
    gStateMachine:render()
    if DEBUG.showFPS then
        displayFPS()
    end
    push:apply("end")
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.resize(w, h)
    push:resize(w, h)
end
