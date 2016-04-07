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
  on "input" targetValue (Signal.message address << action << stToInt)


stToInt : String -> Int
stToInt string =
  case String.toInt string of
    Ok n ->
      n

    _ ->
      0
