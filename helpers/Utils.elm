module Helpers.Utils (..) where

import Html.Events exposing (on, targetValue)
import Signal


onInput address action =
  on "input" targetValue (Signal.message address << action)
