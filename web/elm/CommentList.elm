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

import Comment.Types as T


-- MODEL -----------------------------------------------------------------------

emptyList : List T.Model
emptyList =
  []


commentResponseDecoder : Decode.Decoder T.FetchAllResponse
commentResponseDecoder =
  map2 T.FetchAllResponse
    (field "success" bool)
    (field "results" commentListDecoder)


commentListDecoder : Decode.Decoder (List T.Model)
commentListDecoder =
  list commentDecoder


commentDecoder : Decode.Decoder T.Model
commentDecoder =
  map2 T.Model
    (field "author" string)
    (field "text" string)


-- UPDATE ----------------------------------------------------------------------


update : T.Msg -> List T.Model -> ( List T.Model, Cmd T.Msg )
update msg model =
  case msg of
    T.NoOp ->
      ( model, Cmd.none )

    T.FetchAll ->
      ( model, fetchAll )

    T.FetchAllHandler ( Ok res ) ->
      ( res.results, Cmd.none )

    T.FetchAllHandler ( Err _ ) ->
      ( model, Cmd.none )

    _ ->
      ( model, Cmd.none )


-- OPERATIONS ------------------------------------------------------------------


resourceUrl : String
resourceUrl =
  "/api/comments"


fetchAll : Cmd T.Msg
fetchAll =
  let
    request = Http.get resourceUrl commentResponseDecoder
  in
    Http.send T.FetchAllHandler request


-- VIEW ------------------------------------------------------------------------


renderComment : T.Model -> Html a
renderComment model =
  li []
    [ span [ class "comment" ]
        [ strong [] [ text model.author ]
        , text <| " " ++ model.text
        ]
    ]


view : List T.Model -> Html T.Msg
view models =
  div [ class "comment-list" ]
    [ h4 []
        [ text "Comments "
        , button [ onClick T.FetchAll, class "btn btn-default btn-xs" ] [ text "Refresh" ]
        ]
    , ul [] <| List.map renderComment models
    ]
