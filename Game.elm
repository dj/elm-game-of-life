module Game where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import StartApp.Simple as StartApp 
import Signal exposing (Address)
import Debug

-- UPDATE

type Action =
  NoOp | Step


update action model = 
  case action of
    NoOp ->
      model
    Step ->
      { model | step = model.step + 1 }

-- VIEW
eachRow address row =
  div [ ]
    [ row
      |> toString
      |> text
    ]


board address model =
  div [ ] 
    (List.map (eachRow address) model.board)

view address model =
  div [ ]
    [ board address model,
      button [ onClick address Step ] [(text "step")],
      text (toString model.step)
    ]


-- MODEL
initialModel =
  { board = [ [0, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, 0]
            ],
    step = 0
  }


main =
  StartApp.start
    { model = initialModel,
      view = view,
      update = update
    }

