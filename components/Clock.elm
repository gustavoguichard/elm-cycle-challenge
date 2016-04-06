module Components.Clock (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)


-- MODEL


type alias Model =
  { time : Int }


model : Model
model =
  { time = 0 }



-- UPDATE


type Action
  = Tick
  | ResetClock


update : Action -> Model -> Model
update action model =
  case action of
    Tick ->
      { model | time = model.time + 1 }

    ResetClock ->
      { model | time = 0 }



-- VIEW


view : Address Action -> Model -> Html
view address model =
  h1
    [ style [ ( "background", "royalblue" ) ]
    , onMouseEnter address ResetClock
    ]
    [ span [] [ text <| "seconds elapsed: " ++ toString model.time ] ]
