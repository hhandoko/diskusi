------
-- File     : Comment.elm
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
module Comment exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


-- MODEL -----------------------------------------------------------------------


type alias Model =
  { text : String
  }


type Msg
  = NoOp
  | Fetch


-- UPDATE ----------------------------------------------------------------------


update : Msg -> List Model -> ( List Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    Fetch ->
      ( comments, Cmd.none )


initialModel : List Model
initialModel =
  []


comments : List Model
comments =
  [ { text = "Comment 1" }
  , { text = "Comment 2" }
  , { text = "Comment 3" }
  ]


-- VIEW ------------------------------------------------------------------------


renderComment : Model -> Html a
renderComment model =
  li []
    [ span [ class "comment" ]
        [ strong [] [ text model.text ]
        ]
    ]


view : List Model -> Html Msg
view models =
  div [ class "comment-list" ]
    [ h2 [] [ text "Comments" ]
    , button [ onClick Fetch, class "btn btn-primary" ] [ text "Refresh" ]
    , ul [] <| List.map renderComment models
    ]
