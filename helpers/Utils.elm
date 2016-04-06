module Helpers.Utils (..) where

import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)
import Signal
import String


onInput : Signal.Address a -> (String -> a) -> Attribute
onInput address action =
  on "input" targetValue (Signal.message address << action)


onIntChange : Signal.Address a -> (Int -> a) -> Attribute
onIntChange address action =
  on "input" targetValue (Signal.message address << action << convertToInt)


convertToInt : String -> Int
convertToInt string =
  let
    int' =
      String.toInt string
  in
    case int' of
      Ok n ->
        n

      _ ->
        0
