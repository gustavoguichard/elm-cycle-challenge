module Components.Clock (..) where

import Html exposing (h1, span, text, Html)
import Html.Events exposing (onMouseEnter)
import Signal exposing (Address)


-- MODEL


type alias Model =
  Int


model : Model
model =
  0



-- UPDATE


type Action
  = Tick
  | ResetClock


update : Action -> Model -> Model
update action model =
  case action of
    Tick ->
      model + 1

    ResetClock ->
      0



-- VIEW


view : Address Action -> Model -> Html
view address model =
  h1
    []
    [ span
        [ onMouseEnter address ResetClock ]
        [ text <| "seconds elapsed: " ++ toString model ]
    ]
