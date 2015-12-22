module Game  where

import Html exposing (..)
-- import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Svg
import Svg.Attributes exposing (..)
import StartApp.Simple as App


-- MODEL

type alias Cell =
  { x: Int,
    y: Int
  }

type alias Model = 
  { step: Int,
    size: Int,
    living: List Cell
  }

-- UPDATE

type Action = NoOp | Step


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    Step ->
      { model | step = model.step + 1 }


-- VIEW
cellSize = 50

-- drawCell : Cell -> Svg.Svg
drawCell cell =
  Svg.rect 
    [ x (toString (cell.x * cellSize)), 
      y (toString (cell.y * cellSize)), 
      width (toString cellSize),
      height (toString cellSize),
      style "fill: #efefef"
    ] []

-- drawBoard : Int -> List Cell -> Svg.Svg
drawBoard size living =
  Svg.svg
    [ width (toString (cellSize * size)), height (toString (cellSize * size)), style "background-color: #222" ]
    (List.map drawCell living)


view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ text "Game of Life",
    div []
      [ drawBoard model.size model.living ],
    div [] 
      [ text (toString model.step) ],
    div []
      [ button [ onClick address Step ] [ text "Step" ] ]
  ]

main =
  App.start 
    { view = view, 
      update = update,
      model = 
        { step = 0,
          size = 4,
          living = 
            [ { x = 0, y = 0 },
              { x = 1, y = 1 },
              { x = 2, y = 2 },
              { x = 3, y = 3 }
            ]
        }
    }

