push = require "lib/push" -- https://github.com/Ulydev/push
Class = require "lib/class" -- https://github.com/vrld/hump/blob/master/class.lua

require "src/StateMachine"
require "src/states/BaseState"
require "src/states/StartState"
require "src/states/PlayState"
require "src/states/ServeState"
require "src/states/GameOverState"
require "src/states/HighScoreState"
require "src/states/SaveHighScoreState"
require "src/states/PaddleSelectState"

require "src/classes/Paddle"
require "src/classes/Ball"
require "src/classes/Brick"

require "src/constants"

require "src/utils"
require "src/render"
require "src/quads"
require "src/LevelMaker"
