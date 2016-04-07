module Components.Clock (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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
