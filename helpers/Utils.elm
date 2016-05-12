module Helpers.Utils exposing (..)

import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)
import Json.Decode as Json
import String


onIntChange : (Int -> a) -> Attribute a
onIntChange message =
  on "input" (Json.map (message << parseInt) targetValue)


parseInt : String -> Int
parseInt string =
  case String.toInt string of
    Ok n ->
      n

    _ ->
      0
