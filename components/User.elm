module Components.User (..) where

import Effects exposing (Effects)
import Html exposing (div, h1, h4, a, button, span, text, Html)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, string)
import Json.Decode.Pipeline as Pipeline exposing (decode)
import Signal exposing (Address)
import Task exposing (Task)


-- JSON CONFIG


apiUrl : String
apiUrl =
  "http://jsonplaceholder.typicode.com/users/1"


userDecoder : Decoder User
userDecoder =
  decode User
    |> Pipeline.required "name" string
    |> Pipeline.required "email" string
    |> Pipeline.required "website" string



--EFFECTS


searchUser : String -> Effects Action
searchUser url =
  Effects.task <| performQuery (Http.get userDecoder url)


performQuery : Task Http.Error User -> Task a Action
performQuery task =
  Task.onError (Task.map SuccessfulRequest task) (Task.succeed << RequestError)



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


type Action
  = RequestUser
  | RequestError Http.Error
  | SuccessfulRequest User


update : Action -> Model -> ( Model, Effects.Effects Action )
update action model =
  case action of
    RequestUser ->
      ( { model | loading = True }, searchUser apiUrl )

    RequestError error ->
      let
        foo =
          Debug.log "Erro: " error
      in
        ( { model | loading = False }, Effects.none )

    SuccessfulRequest user ->
      ( { model | user = Just user, loading = False }, Effects.none )



-- VIEW


userView : User -> Html
userView user =
  div
    []
    [ h1 [] [ text user.name ]
    , h4 [] [ text user.email ]
    , a [ href "#" ] [ text user.website ]
    ]


view : Address Action -> Model -> Html
view address model =
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
      [ button [ onClick address RequestUser ] [ text "Get first user" ]
      , userHtml
      , text loading
      ]
