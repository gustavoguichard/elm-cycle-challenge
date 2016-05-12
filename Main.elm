module Main exposing (..)

import Components.BMI as BMI
import Components.Clock as Clock
import Components.Counter as Counter
import Components.Hello as Hello
import Components.User as User
import Html exposing (main', hr, Html)
import Html.App as App
import Task exposing (Task)
import Time exposing (second)


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


type Msg
  = NoOp
  | MsgForBMI BMI.Msg
  | MsgForClock Clock.Msg
  | MsgForCounter Counter.Msg
  | MsgForHello Hello.Msg
  | MsgForUser User.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msgFor model =
  case msgFor of
    MsgForBMI msg ->
      { model | bmi = BMI.update msg model.bmi } ! []

    MsgForClock msg ->
      { model | clock = Clock.update msg model.clock } ! []

    MsgForCounter msg ->
      { model | counter = Counter.update msg model.counter } ! []

    MsgForHello msg ->
      { model | hello = Hello.update msg model.hello } ! []

    MsgForUser msg ->
      let
        ( user, fx ) =
          User.update msg model.user
      in
        { model | user = user } ! [ Cmd.map MsgForUser fx ]

    NoOp ->
      model ! []



-- VIEW


view : Model -> Html Msg
view model =
  main'
    []
    [ App.map MsgForBMI (BMI.view model.bmi)
    , hr [] []
    , App.map MsgForHello (Hello.view model.hello)
    , hr [] []
    , App.map MsgForCounter (Counter.view model.counter)
    , hr [] []
    , App.map MsgForClock (Clock.view model.clock)
    , hr [] []
    , App.map MsgForUser (User.view model.user)
    ]


-- Subscriptions
subscriptions : Model -> Sub Msg
subscriptions _ =
  Time.every second (MsgForClock Clock.Tick |> always)



-- APP


main : Program Never
main =
  App.program
    { view = view
    , update = update
    , init = ( model, Cmd.none )
    , subscriptions = subscriptions
    }
