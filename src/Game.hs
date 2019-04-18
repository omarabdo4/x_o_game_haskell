module Game where

import Data.Array

-- Player is a new data type initialized and deriving is to print a Player's result in the screen as a string

data Player = PlayerX | PlayerO deriving (Eq, Show)
-- Type is pretty same as type in c it just indicate the varable's data type to another one
-- Maybe is indicate if Cell contain PlayerX or PlayerO with keyword (Just PlayerO) or (Nothing)
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
screenWidth = 550

screenHeight :: Int
screenHeight = 390

cellWidth :: Float
cellWidth = fromIntegral screenWidth / fromIntegral n

cellHeight :: Float
cellHeight = fromIntegral screenHeight / fromIntegral n

initialGame = Game { gameBoard = array indexRange (zip (range indexRange) (repeat Nothing))
                   , gamePlayer = PlayerO
                   , gameState = Running
                   }
    where indexRange = ((0, 0), (n - 1, n - 1))
