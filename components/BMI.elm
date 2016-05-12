module Components.BMI exposing (..)

import Components.LabeledSlider as Slider
import Html exposing (div, h2, text, Html)
import Html.App exposing (map)
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


type Msg
  = UpdateHeight Slider.Msg
  | UpdateWeight Slider.Msg


update : Msg -> Model -> Model
update msgFor model =
  case msgFor of
    UpdateHeight msg ->
      { model | height = Slider.update msg model.height }

    UpdateWeight msg ->
      { model | weight = Slider.update msg model.weight }



-- VIEW


toBmi : Model -> Int
toBmi model =
  let
    heightMeters =
      (toFloat model.height.value / 100) ^ 2
  in
    round <| toFloat model.weight.value / heightMeters


view : Model -> Html Msg
view model =
  div
    []
    [ map UpdateWeight (Slider.view model.weight)
    , map UpdateHeight (Slider.view model.height)
    , h2 [] [ text <| (++) "BMI is " <| toString <| toBmi model ]
    ]
