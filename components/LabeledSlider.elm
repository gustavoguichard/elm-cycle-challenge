module Components.LabeledSlider (..) where

import Helpers.Utils exposing (onIntChange)
import Html exposing (div, label, input, text, Html)
import Html.Attributes as Attr
import Signal exposing (Address)


-- MODEL


type alias Model =
  { label : String
  , unit : String
  , min : Int
  , max : Int
  , value : Int
  }


model : Model
model =
  Model "" "cm" 0 0 0



-- UPDATE


type Action
  = UpdateValue Int


update : Action -> Model -> Model
update action model =
  case action of
    UpdateValue value ->
      { model | value = value }



-- VIEW


view : Address Action -> Model -> Html
view address model =
  div
    []
    [ label [] [ text (model.label ++ " " ++ (toString model.value) ++ model.unit) ]
    , input
        [ Attr.type' "range"
        , Attr.max <| toString model.max
        , Attr.min <| toString model.min
        , Attr.value <| toString model.value
        , onIntChange address UpdateValue
        ]
        []
    ]
