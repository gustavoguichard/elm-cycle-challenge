module Components.LabeledSlider (..) where

import Helpers.Utils exposing (onIntChange)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Signal exposing (Address)


-- MODEL


type alias Props =
  { label : String
  , unit : String
  , min : Int
  , max : Int
  , init : Int
  }


type alias Model =
  { value : Int
  , props : Props
  }


defaultProps : Props
defaultProps =
  Props "" "cm" 0 0 0


modelWithProps : Props -> Model
modelWithProps props =
  { value = props.init
  , props = props
  }


model : Model
model =
  { value = 0
  , props = defaultProps
  }



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
    [ label [] [ text (model.props.label ++ " " ++ (toString model.value) ++ model.props.unit) ]
    , br [] []
    , input
        [ type' "range"
        , class "slider"
        , Attr.max <| toString model.props.max
        , Attr.min <| toString model.props.min
        , value <| toString model.value
        , onIntChange address UpdateValue
        ]
        []
    ]
