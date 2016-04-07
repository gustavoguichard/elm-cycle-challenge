module Components.BMI (..) where

import Components.LabeledSlider as Slider
import Html exposing (..)
import Signal exposing (Address)
import String


-- MODEL


type alias Model =
  { height : Slider.Model
  , weight : Slider.Model
  }


model : Model
model =
  { height = Slider.Model "Height" "cm" 140 220 170
  , weight = Slider.Model "Weight" "kg" 40 150 70
  }



-- UPDATE


type Action
  = UpdateHeight Slider.Action
  | UpdateWeight Slider.Action


update : Action -> Model -> Model
update actionFor model =
  case actionFor of
    UpdateHeight action ->
      { model | height = Slider.update action model.height }

    UpdateWeight action ->
      { model | weight = Slider.update action model.weight }



-- VIEW


toBmi : Model -> Int
toBmi model =
  let
    heightMeters =
      (toFloat model.height.value / 100) ^ 2
  in
    round <| toFloat model.weight.value / heightMeters


view : Address Action -> Model -> Html
view address model =
  div
    []
    [ Slider.view (Signal.forwardTo address UpdateWeight) model.weight
    , Slider.view (Signal.forwardTo address UpdateHeight) model.height
    , h2 [] [ text <| (++) "BMI is " <| toString <| toBmi model ]
    ]
