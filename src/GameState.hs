module GameState where

import Data.Array

--"data" allows you to introduce a new algebraic data type
-- while "type" just makes a type synonym

data Player = PlayerX | PlayerO deriving (Eq, Show)
type Cell = Maybe Player
data State = Running | GameOver (Maybe Player) deriving (Eq, Show)

type Board = Array (Int, Int) Cell

data Game = Game { gameBoard :: Board
                    , gamePlayer :: Player
                    , gameState :: State
                    } deriving (Eq, Show)

n :: Int
n = 3

screenWidth :: Int
screenWidth = 640

screenHeight :: Int
screenHeight = 480

cellWidth :: Float
cellWidth = fromIntegral screenWidth / fromIntegral n

cellHeight :: Float
cellHeight = fromIntegral screenHeight / fromIntegral n

initialGame = Game { gameBoard = array indexRange $ zip (range indexRange) ([Nothing | x <- [1..9]])
                    , gamePlayer = PlayerX
                    , gameState = Running
                    }
    where indexRange = ((0, 0), (n - 1, n - 1))

-- " $ Something " <= used instead of parentheses = " (Something) "
-- range ((0,0),(2,2)) => [(0,0),(0,1),(0,2),(1,0),(1,1),(1,2),(2,0),(2,1),(2,2)]
-- second argument of function making gameBoard = 
--[((0,0),Nothing),((0,1),Nothing),((0,2),Nothing),((1,0),Nothing),((1,1),Nothing),((1,2),Nothing),((2,0),Nothing),((2,1),Nothing),((2,2),Nothing)]