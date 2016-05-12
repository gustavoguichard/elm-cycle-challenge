module Components.Hello exposing (..)

import Html exposing (div, label, input, text, hr, h1, Html)
import Html.Attributes exposing (type')
import Html.Events exposing (onInput)

-- MODEL


type alias Model =
  String


model : Model
model =
  ""



-- UPDATE


type Msg
  = UpdateField String


update : Msg -> Model -> Model
update msg model =
  case msg of
    UpdateField string ->
      string



-- VIEW


view : Model -> Html Msg
view model =
  div
    []
    [ label [] [ text "Name:" ]
    , input
        [ type' "text"
        , onInput UpdateField
        ]
        []
    , hr [] []
    , h1 [] [ text <| "Hello " ++ model ++ "!" ]
    ]
