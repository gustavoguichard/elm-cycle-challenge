module Main (..) where

import Components.Clock as Clock
import Components.Counter as Counter
import Components.Hello as Hello
import Components.LabeledSlider as Slider
import Components.User as User
import Effects
import Html exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address, forwardTo)
import StartApp
import Task exposing (Task)
import Time exposing (every, second)


-- MODEL


type alias Model =
  { clock : Clock.Model
  , hello : Hello.Model
  , counter : Counter.Model
  , user : User.Model
  , slider : Slider.Model
  }


model : Model
model =
  { clock = Clock.model
  , hello = Hello.model
  , counter = Counter.model
  , user = User.model
  , slider = Slider.modelWithProps { unit = "cm", label = "Height", min = 140, max = 220, init = 170 }
  }



-- UPDATE


type Action
  = NoOp
  | ActionForClock Clock.Action
  | ActionForCounter Counter.Action
  | ActionForHello Hello.Action
  | ActionForSlider Slider.Action
  | ActionForUser User.Action


update : Action -> Model -> ( Model, Effects.Effects Action )
update actionFor model =
  case actionFor of
    ActionForClock action ->
      ( { model | clock = Clock.update action model.clock }, Effects.none )

    ActionForCounter action ->
      ( { model | counter = Counter.update action model.counter }, Effects.none )

    ActionForHello action ->
      ( { model | hello = Hello.update action model.hello }, Effects.none )

    ActionForSlider action ->
      ( { model | slider = Slider.update action model.slider }, Effects.none )

    ActionForUser action ->
      let
        ( user, fx ) =
          User.update action model.user
      in
        ( { model | user = user }, Effects.map ActionForUser fx )

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
    , divisor
    , Counter.view (forwardTo address ActionForCounter) model.counter
    , divisor
    , User.view (forwardTo address ActionForUser) model.user
    , divisor
    , Slider.view (forwardTo address ActionForSlider) model.slider
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


port tasks : Signal (Task Effects.Never ())
port tasks =
  app.tasks
