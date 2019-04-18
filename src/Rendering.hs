module Rendering where

import Data.Array

import Graphics.Gloss

import Game

boardGridColor = makeColorI 0 0 0 255
playerXColor = makeColorI 211 123 40 255
playerOColor = makeColorI 40 185 211 255
tieColor = makeColorI 211 74 40 255

boardAsRunningPicture board =
    pictures [ color playerXColor $ xCellsOfBoard board
             , color playerOColor $ oCellsOfBoard board
             , color boardGridColor $ boardGrid
             ]

outcomeColor (Just PlayerX) = playerXColor
outcomeColor (Just PlayerO) = playerOColor
outcomeColor Nothing = tieColor

snapPictureToCell picture (row, column) = translate x y picture
    where x = fromIntegral column * cellWidth + cellWidth * 0.5
          y = fromIntegral row * cellHeight + cellHeight * 0.5

-- Draw X Shape
xCell :: Picture
xCell = pictures [ rotate 45.0 $ rectangleWire side 12.0
                 , rotate (-45.0) $ rectangleWire side 12.0
                 ]
    where side = min cellWidth cellHeight * 0.75

-- Draw O Shape
oCell :: Picture
oCell = thickCircle radius 12.0
    where radius = min cellWidth cellHeight * 0.25

cellsOfBoard :: Board -> Cell -> Picture -> Picture
cellsOfBoard board cell cellPicture =
    pictures
    $ map (snapPictureToCell cellPicture . fst)
    $ filter (\(_, e) -> e == cell)
    $ assocs board

xCellsOfBoard :: Board -> Picture
xCellsOfBoard board = cellsOfBoard board (Just PlayerX) xCell

oCellsOfBoard :: Board -> Picture
oCellsOfBoard board = cellsOfBoard board (Just PlayerO) oCell

boardGrid :: Picture
boardGrid =
    pictures
    $ concatMap (\i -> [ line [ (i * cellWidth, 0.0)
                              , (i * cellWidth, fromIntegral screenHeight)
                              ]
                       , line [ (0.0,                      i * cellHeight)
                              , (fromIntegral screenWidth, i * cellHeight)
                              ]
                       ])
      [0.0 .. fromIntegral n]
showGameOverText :: Picture
showGameOverText = Translate (fromIntegral screenWidth / 2.5) (fromIntegral screenHeight / 2) $ Scale 0.3 0.3 $ Text "Game Over"

boardAsPicture board =
    pictures [ xCellsOfBoard board
             , oCellsOfBoard board
             , boardGrid
             , showGameOverText
             ]

boardAsGameOverPicture winner board = color (outcomeColor winner) (boardAsPicture board)

gameAsPicture :: Game -> Picture
gameAsPicture game = translate (fromIntegral screenWidth * (-0.5))
                               (fromIntegral screenHeight * (-0.5))
                               frame
    where frame = case gameState game of
        -- Initialized two pictures running (continue put x or o ) or gameOver 
                    Running -> boardAsRunningPicture (gameBoard game)
                    -- winner is PlayerX or PlayerO or maybe Nothing
                    GameOver winner -> boardAsGameOverPicture winner (gameBoard game)
