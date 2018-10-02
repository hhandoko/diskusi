------
-- File     : Comment/View.elm
-- License  :
--   Copyright (c) 2017 - 2018 Herdy Handoko
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


module Comment.View exposing (..)

import Comment.Types as T
import CommentForm as F exposing (..)
import Date.Format exposing (format)
import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)


-- MODEL -----------------------------------------------------------------------


emptyList : List T.ViewModel
emptyList =
  []



-- VIEW ------------------------------------------------------------------------


viewReply : T.ViewModel -> Html T.Msg
viewReply model =
  if model.show_reply_form then
    F.view (T.FormModel model.ref "" "")
  else
    div [ style [ ( "margin-top", "10px" ) ] ]
      [ button
          [ class "btn btn-default btn-sm"
          , onClick (T.ShowReplyForm model.ref)
          ]
          [ text "Reply" ]
      ]


view : T.ViewModel -> Html T.Msg
view model =
  li
    [ style [ ( "margin-bottom", "20px" ) ] ]
    [ div [ class "author" ]
        [ strong [] [ text model.author ]
        , small
            [ class "text-muted"
            , style [ ( "margin-left", "10px" ) ]
            ]
            [ text <| format "%d/%m/%Y" model.created ]
        ]
    , div [ class "comment" ]
        [ text <| " " ++ model.text ]
    , viewReply model
    ]
