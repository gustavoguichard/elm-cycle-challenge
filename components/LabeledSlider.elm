module Components.LabeledSlider exposing (..)

import Helpers.Utils exposing (onIntChange)
import Html exposing (div, label, input, text, Html)
import Html.Attributes as Attr


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


type Msg
  = UpdateValue Int


update : Msg -> Model -> Model
update msg model =
  case msg of
    UpdateValue value ->
      { model | value = value }



-- VIEW


view : Model -> Html Msg
view model =
  div
    []
    [ label [] [ text (model.label ++ " " ++ (toString model.value) ++ model.unit) ]
    , input
        [ Attr.type' "range"
        , Attr.max <| toString model.max
        , Attr.min <| toString model.min
        , Attr.value <| toString model.value
        , onIntChange UpdateValue
        ]
        []
    ]
