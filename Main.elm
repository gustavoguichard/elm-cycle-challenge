module Main (..) where

import Effects
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal
import StartApp
import Time exposing (every, second)


-- MODEL


type alias Model =
  { time : Int }


model : Model
model =
  { time = 0 }



-- UPDATE


type Action
  = NoOp
  | Tick
  | ResetClock


update : Action -> Model -> ( Model, Effects.Effects a )
update action model =
  case action of
    Tick ->
      ( { model | time = model.time + 1 }, Effects.none )

    ResetClock ->
      ( { model | time = 0 }, Effects.none )

    NoOp ->
      ( model, Effects.none )



-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  h1
    [ style [ ( "background", "royalblue" ) ]
    , onMouseEnter address ResetClock
    ]
    [ span [] [ text <| "seconds elapsed: " ++ toString model.time ] ]



-- APP


app : StartApp.App Model
app =
  StartApp.start
    { view = view
    , update = update
    , init = ( model, Effects.none )
    , inputs = [ Signal.map (always Tick) (every second) ]
    }


main : Signal Html
main =
  app.html
