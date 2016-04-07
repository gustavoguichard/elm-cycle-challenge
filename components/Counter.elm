module Components.Counter (..) where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Signal exposing (Address)


-- MODEL


type alias Model =
  Int


model : Model
model =
  0



-- UPDATE


type Action
  = Increment
  | Decrement


update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      model + 1

    Decrement ->
      max 0 (model - 1)



-- VIEW


view : Address Action -> Model -> Html
view address model =
  div
    []
    [ button [ onClick address Increment ] [ text "Increment" ]
    , button [ onClick address Decrement ] [ text "Decrement" ]
    , p [] [ label [] [ text <| toString model ] ]
    ]
