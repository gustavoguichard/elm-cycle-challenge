module Components.Counter exposing (..)

import Html exposing (div, button, p, label, text, Html)
import Html.Attributes exposing (style)
import Html.Events exposing (..)


-- MODEL


type alias Model =
  Int


model : Model
model =
  0



-- UPDATE


type Msg
  = Increment
  | Decrement


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      max 0 (model - 1)



-- VIEW


view : Model -> Html Msg
view model =
  div
    []
    [ button [ onClick Increment ] [ text "Increment" ]
    , button [ onClick Decrement ] [ text "Decrement" ]
    , p [] [ label [] [ text <| toString model ] ]
    ]
