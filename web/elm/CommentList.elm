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

import Comment.Operations as O
import Comment.Types as T
import CommentForm as F exposing (..)
import Date.Format exposing (format)
import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)


-- MODEL -----------------------------------------------------------------------


emptyList : List T.Model
emptyList =
  []



-- UPDATE ----------------------------------------------------------------------


update : T.Msg -> List T.Model -> ( List T.Model, Cmd T.Msg )
update msg models =
  case msg of
    T.ShowReplyForm ref ->
      let
        show model =
          if model.ref == ref then
            { model | show_reply_form = True }
          else
            model
      in
      ( List.map show models, Cmd.none )

    T.FetchAll ->
      ( models, O.fetchAll )

    T.FetchAllHandler (Ok res) ->
      ( res.results, Cmd.none )

    T.FetchAllHandler (Err _) ->
      ( models, Cmd.none )

    _ ->
      ( models, Cmd.none )



-- VIEW ------------------------------------------------------------------------


renderReply : T.Model -> Html T.Msg
renderReply model =
  if model.show_reply_form then
    F.view (T.FormModel model.ref "" "")
  else
    div
      [ style [ ( "margin-top", "10px" ) ] ]
      [ button [ onClick (T.ShowReplyForm model.ref), class "btn btn-default btn-sm" ] [ text "Reply" ] ]


renderComment : T.Model -> Html T.Msg
renderComment model =
  li
    [ style [ ( "margin-bottom", "20px" ) ] ]
    [ div
        [ class "author" ]
        [ strong [] [ text model.author ]
        , small
            [ class "text-muted"
            , style [ ( "margin-left", "10px" ) ]
            ]
            [ text <| format "%d/%m/%Y" model.created ]
        ]
    , div
        [ class "comment" ]
        [ text <| " " ++ model.text ]
    , renderReply model
    ]


view : List T.Model -> Html T.Msg
view models =
  div
    [ class "comment-list" ]
    [ h4
        []
        [ text "Comments "
        , button [ onClick T.FetchAll, class "btn btn-default btn-xs" ] [ text "Refresh" ]
        ]
    , ul [] <| List.map renderComment models
    ]
