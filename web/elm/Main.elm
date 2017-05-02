------
-- File     : Main.elm
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
module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)

import Comment exposing (..)


main =
  program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- MODEL -----------------------------------------------------------------------


type alias Model =
  { comments : List Comment.Model
  }


type Msg
  = NoOp
  | CommentMsg Comment.Msg


init : ( Model, Cmd Msg )
init =
  ( { comments = Comment.initialModel }, Cmd.map CommentMsg Comment.fetchAll )


-- UPDATE ----------------------------------------------------------------------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    CommentMsg commentMsg ->
      let
        ( updatedModel, cmd ) =
          Comment.update commentMsg model.comments
      in
        ( { model | comments = updatedModel }, Cmd.map CommentMsg cmd )
    _ ->
      ( model, Cmd.none )


-- SUBSCRIPTION ----------------------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW ------------------------------------------------------------------------


view : Model -> Html Msg
view model =
  div [ class "app" ]
    [ map CommentMsg <| Comment.view model.comments
    ]
