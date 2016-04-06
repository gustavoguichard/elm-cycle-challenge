module Main (..) where

import Effects
import Html exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address, forwardTo)
import StartApp
import Time exposing (every, second)
import Components.Clock as Clock
import Components.Hello as Hello


-- MODEL


type alias Model =
  { clock : Clock.Model
  , hello : Hello.Model
  }


model : Model
model =
  { clock = Clock.model
  , hello = Hello.model
  }



-- UPDATE


type Action
  = NoOp
  | ActionForClock Clock.Action
  | ActionForHello Hello.Action


update : Action -> Model -> ( Model, Effects.Effects a )
update actionFor model =
  case actionFor of
    ActionForClock action ->
      ( { model | clock = Clock.update action model.clock }, Effects.none )

    ActionForHello action ->
      ( { model | hello = Hello.update action model.hello }, Effects.none )

    NoOp ->
      ( model, Effects.none )



-- VIEW


divisor : Html
divisor =
  hr [ style [ ( "padding", "20px 0" ) ] ] []


view : Address Action -> Model -> Html
view address model =
  main'
    [ class "main-content" ]
    [ Clock.view (forwardTo address ActionForClock) model.clock
    , divisor
    , Hello.view (forwardTo address ActionForHello) model.hello
    ]



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
