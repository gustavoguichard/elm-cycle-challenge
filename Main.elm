module Main (..) where

import Components.BMI as BMI
import Components.Clock as Clock
import Components.Counter as Counter
import Components.Hello as Hello
import Components.User as User
import Effects
import Html exposing (main', hr, Html)
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
  , bmi : BMI.Model
  }


model : Model
model =
  { clock = Clock.model
  , hello = Hello.model
  , counter = Counter.model
  , user = User.model
  , bmi = BMI.model
  }



-- UPDATE


type Action
  = NoOp
  | ActionForBMI BMI.Action
  | ActionForClock Clock.Action
  | ActionForCounter Counter.Action
  | ActionForHello Hello.Action
  | ActionForUser User.Action


update : Action -> Model -> ( Model, Effects.Effects Action )
update actionFor model =
  case actionFor of
    ActionForBMI action ->
      ( { model | bmi = BMI.update action model.bmi }, Effects.none )

    ActionForClock action ->
      ( { model | clock = Clock.update action model.clock }, Effects.none )

    ActionForCounter action ->
      ( { model | counter = Counter.update action model.counter }, Effects.none )

    ActionForHello action ->
      ( { model | hello = Hello.update action model.hello }, Effects.none )

    ActionForUser action ->
      let
        ( user, fx ) =
          User.update action model.user
      in
        ( { model | user = user }, Effects.map ActionForUser fx )

    NoOp ->
      ( model, Effects.none )



-- VIEW


view : Address Action -> Model -> Html
view address model =
  main'
    []
    [ BMI.view (forwardTo address ActionForBMI) model.bmi
    , hr [] []
    , Hello.view (forwardTo address ActionForHello) model.hello
    , hr [] []
    , Counter.view (forwardTo address ActionForCounter) model.counter
    , hr [] []
    , Clock.view (forwardTo address ActionForClock) model.clock
    , hr [] []
    , User.view (forwardTo address ActionForUser) model.user
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
