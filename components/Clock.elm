module Components.Clock exposing (..)

import Html exposing (h1, span, text, Html)
import Html.Events exposing (onMouseEnter)


-- MODEL


type alias Model =
  Int


model : Model
model =
  0



-- UPDATE


type Msg
  = Tick
  | ResetClock


update : Msg -> Model -> Model
update msg model =
  case msg of
    Tick ->
      model + 1

    ResetClock ->
      0



-- VIEW


view : Model -> Html Msg
view model =
  h1
    []
    [ span
        [ onMouseEnter ResetClock ]
        [ text <| "seconds elapsed: " ++ toString model ]
    ]
