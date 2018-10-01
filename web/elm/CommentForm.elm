------
-- File     : CommentForm.elm
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


module CommentForm exposing (..)

import Comment.Operations as O
import Comment.Types as T
import Html exposing (..)
import Html.Attributes exposing (class, for, id, rows, style, type_)
import Html.Events exposing (keyCode, on, onClick, onInput)
import Json.Decode as Decode


-- MODEL -----------------------------------------------------------------------


emptyForm : T.FormModel
emptyForm =
  T.FormModel "" "" ""



-- UPDATE ----------------------------------------------------------------------


update : T.Msg -> T.FormModel -> Bool -> ( T.FormModel, Cmd T.Msg )
update msg model onEnter =
  case msg of
    T.SetAuthor author ->
      ( { model | author = author }, Cmd.none )

    T.SetText text ->
      ( { model | text = text }, Cmd.none )

    {- On ENTER keydown -}
    T.KeyDown key ->
      if key == 13 && onEnter then
        ( model, O.post model )
      else
        ( model, Cmd.none )

    T.Submit ->
      ( model, O.post model )

    T.SubmitHandler (Ok res) ->
      ( emptyForm, Cmd.none )

    T.SubmitHandler (Err _) ->
      ( model, Cmd.none )

    _ ->
      ( model, Cmd.none )


{-| Currently there are no native onEnter event, so the second best thing is to filter KeyDown event.

    See:
      - http://stackoverflow.com/a/40114176
      - http://package.elm-lang.org/packages/elm-community/html-extra/latest/Html-Events-Extra#onEnter

-}
onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
  on "keydown" <| Decode.map tagger keyCode



-- VIEW ------------------------------------------------------------------------


view : T.FormModel -> Html T.Msg
view model =
  div [ class "comment-form" ]
    [ div [ id "post_comment_form" ]
        [ div [ class "form-group" ]
            [ label [ for "author" ] [ text "Name" ]
            , input
                [ id "author"
                , class "form-control"
                , type_ "text"
                , Html.Attributes.value model.author
                , onInput T.SetAuthor
                , onKeyDown T.KeyDown
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label [ for "text" ] [ text "Comment" ]
            , textarea
                [ id "text"
                , class "form-control"
                , rows 6
                , Html.Attributes.value model.text
                , onInput T.SetText
                , onKeyDown T.KeyDown
                ]
                []
            ]
        , div [ class "form-group text-right" ]
            [ button
                [ class "btn btn-primary"
                , onClick T.Submit
                ]
                [ text "Submit" ]
            ]
        ]
    ]
