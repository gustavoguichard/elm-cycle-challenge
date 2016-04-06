module Main (..) where

import Effects
import Html exposing (..)
import Signal exposing (Address, forwardTo)
import StartApp
import Time exposing (every, second)
import Components.Clock as Clock


-- MODEL


type alias Model =
  { clock : Clock.Model }


model : Model
model =
  { clock = Clock.model }



-- UPDATE


type Action
  = NoOp
  | ActionForClock Clock.Action


update : Action -> Model -> ( Model, Effects.Effects a )
update actionFor model =
  case actionFor of
    ActionForClock action ->
      ( { model | clock = Clock.update action model.clock }, Effects.none )

    NoOp ->
      ( model, Effects.none )



-- VIEW


view : Address Action -> Model -> Html
view address model =
  Clock.view (forwardTo address ActionForClock) model.clock



-- APP


app : StartApp.App Model
app =
  StartApp.start
    { view = view
    , update = update
    , init = ( model, Effects.none )
    , inputs = [ Signal.map (always (ActionForClock Clock.Tick)) (every second) ]
    }


main : Signal Html
main =
  app.html
