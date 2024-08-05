-- Size of our actual window.
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Size we're trying to emulate with push.
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

MIN_ROWS = 1
MAX_ROWS = 5

MIN_COLS = 5
MAX_COLS = 8

N_BRICK_COLORS = 5
N_BRICK_TIERS = 4
N_PADDLE_COLORS = 4
N_PADDLE_TIERS = 4
N_BALL_COLORS = 7

MAX_HEALTH = 5

BALL_SPEED_LIMIT = {
    X = {
        MIN = 50,
        MAX = 200
    },
    Y = {
        MIN = 50,
        MAX = 60
    }
}

SPRITE_SIZE = {
    ARROW = 24,
    BALL = 8,
    HEART = {
        X = 10,
        Y = 9
    },
    PADDLE = {
        {X = 32},
        {X = 64},
        {X = 96},
        {X = 128},
        Y = 16
    },
    BRICK = {
        X = 32,
        Y = 16
    }
}

BRICK_WALL_INDENT = SPRITE_SIZE.BRICK.X / 2 * 3
