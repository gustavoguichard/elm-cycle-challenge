module Components.User exposing (..)

import Html exposing (div, h1, h4, a, button, span, text, Html)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, object3, string, (:=))
import Task exposing (Task)


-- JSON CONFIG


apiUrl : String
apiUrl =
  "http://jsonplaceholder.typicode.com/users/1"


userDecoder : Decoder User
userDecoder =
  object3 User
    ("name" := string)
    ("email" := string)
    ("website" := string)


--EFFECTS


searchUser : String -> Cmd Msg
searchUser url =
  Task.perform RequestError SuccessfulRequest (Http.get userDecoder url)



-- MODEL


type alias User =
  { name : String
  , email : String
  , website : String
  }


type alias Model =
  { user : Maybe User
  , loading : Bool
  }


model : Model
model =
  Model Nothing False



-- UPDATE


type Msg
  = RequestUser
  | RequestError Http.Error
  | SuccessfulRequest User


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    RequestUser ->
      { model | loading = True } ! [ searchUser apiUrl ]

    RequestError error ->
      let
        foo =
          Debug.log "Erro: " error
      in
        { model | loading = False } ! []

    SuccessfulRequest user ->
      { model | user = Just user, loading = False } ! []



-- VIEW


userView : User -> Html Msg
userView user =
  div
    []
    [ h1 [] [ text user.name ]
    , h4 [] [ text user.email ]
    , a [ href "#" ] [ text user.website ]
    ]


view : Model -> Html Msg
view model =
  let
    userHtml =
      case model.user of
        Just user' ->
          userView user'

        Nothing ->
          span [] []

    loading =
      if model.loading then
        "Loading..."
      else
        ""
  in
    div
      []
      [ button [ onClick RequestUser ] [ text "Get first user" ]
      , userHtml
      , text loading
      ]
