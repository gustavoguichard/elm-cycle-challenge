module Main (..) where

import Html exposing (..)
import Signal
import StartApp exposing (start)
import Time exposing (every, second)
import Effects


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


update : Action -> Model -> ( Model, Effects.Effects a )
update action model =
  ( model, Effects.none )



-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  div [] []



-- APP


app : StartApp.App Model
app =
  start
    { view = view
    , update = update
    , init = ( model, Effects.none )
    , inputs = [ Signal.map (always Tick) (every second) ]
    }


main : Signal Html
main =
  app.html
