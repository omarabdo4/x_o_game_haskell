module Main where

import Graphics.Gloss
import Graphics.Gloss.Data.Color

import Game
import Logic
import Rendering

window = InWindow "Our PL3 Project" (screenWidth, screenHeight) (100, 100)
backgroundColor = makeColor 255 255 255 255

-- 30 = Number of simulation steps to take for each second of real time.
-- initialGame = A function to convert the world a picture. (Picture is a datatype which gloss can convert it into GUI )
-- gameAsPicture = it must handle input events
-- transformGame = something like reload the picture with the new updated state (when you click to add a X, it envoked to one iteration until an event occured)
main :: IO ()
main = play window backgroundColor 30 initialGame gameAsPicture transformGame (const id)
