------
-- File     : CommentList.elm
-- License  :
--   Copyright (c) 2017 Herdy Handoko
--
--   Licensed under the Apache License, Version 2.0 (the "License");
--   you may not use this file except in compliance with the License.
--   You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License.
------
module CommentList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (..)


-- MODEL -----------------------------------------------------------------------


type alias Model =
  { author : String
  , text : String
  }


type Msg
  = NoOp
  | FetchAll
  | FetchAllHandler (Result Http.Error CommentResponse)


type alias CommentResponse =
  { success : Bool
  , results : List Model
  }


emptyList : List Model
emptyList =
  []


commentResponseDecoder : Decode.Decoder CommentResponse
commentResponseDecoder =
  map2 CommentResponse
    (field "success" bool)
    (field "results" commentListDecoder)


commentListDecoder : Decode.Decoder (List Model)
commentListDecoder =
  list commentDecoder


commentDecoder : Decode.Decoder Model
commentDecoder =
  map2 Model
    (field "author" string)
    (field "text" string)


-- UPDATE ----------------------------------------------------------------------


update : Msg -> List Model -> ( List Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )

    FetchAll ->
      ( model, fetchAll )

    FetchAllHandler ( Ok res ) ->
      ( res.results, Cmd.none )

    FetchAllHandler ( Err _ ) ->
      ( model, Cmd.none )


-- OPERATIONS ------------------------------------------------------------------


resourceUrl : String
resourceUrl =
  "/api/comments"


fetchAll : Cmd Msg
fetchAll =
  let
    request = Http.get resourceUrl commentResponseDecoder
  in
    Http.send FetchAllHandler request


-- VIEW ------------------------------------------------------------------------


renderComment : Model -> Html a
renderComment model =
  li []
    [ span [ class "comment" ]
        [ strong [] [ text model.author ]
        , text <| " " ++ model.text
        ]
    ]


view : List Model -> Html Msg
view models =
  div [ class "comment-list" ]
    [ h4 []
        [ text "Comments "
        , button [ onClick FetchAll, class "btn btn-default btn-xs" ] [ text "Refresh" ]
        ]
    , ul [] <| List.map renderComment models
    ]
