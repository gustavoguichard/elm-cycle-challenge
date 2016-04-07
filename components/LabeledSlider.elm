module Components.LabeledSlider (..) where

import Helpers.Utils exposing (onIntChange)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
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
    [ class "labeled-slider"
    , style [ ( "text-align", "center" ) ]
    ]
    [ label [] [ text (model.label ++ " " ++ (toString model.value) ++ model.unit) ]
    , br [] []
    , input
        [ type' "range"
        , class "slider"
        , Attr.max <| toString model.max
        , Attr.min <| toString model.min
        , value <| toString model.value
        , onIntChange address UpdateValue
        ]
        []
    ]
