module Components.Hello (..) where

import Helpers.Utils exposing (onInput)
import Html exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address)


-- MODEL


type alias Model =
  String


model : Model
model =
  ""



-- UPDATE


type Action
  = UpdateField String


update : Action -> Model -> Model
update action model =
  case action of
    UpdateField string ->
      string



-- VIEW


view : Address Action -> Model -> Html
view address model =
  div
    []
    [ label [] [ text "Name:" ]
    , input
        [ type' "text"
        , onInput address UpdateField
        ]
        []
    , hr [] []
    , h1 [] [ text <| "Hello " ++ model ++ "!" ]
    ]
