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

import Html exposing (..)
import Html.Attributes exposing (class, for, id, rows, type_)
import Html.Events exposing (keyCode, on, onClick, onInput)
import Http
import Json.Decode as Decode
import Json.Encode as Encode

import Comment.Types as T


-- MODEL -----------------------------------------------------------------------


emptyForm : T.Model
emptyForm =
  T.Model "" ""


postResponseDecoder : Decode.Decoder T.PostResponse
postResponseDecoder =
  Decode.map2 T.PostResponse
    (Decode.field "success" Decode.bool)
    (Decode.field "message" Decode.string)


postEncoder : T.Model -> Encode.Value
postEncoder model =
  Encode.object
    [ ("comment", commentEncoder model) ]


commentEncoder : T.Model -> Encode.Value
commentEncoder model =
  Encode.object
    [ ("author", Encode.string model.author)
    , ("text", Encode.string model.text)
    ]


-- UPDATE ----------------------------------------------------------------------


update : T.Msg -> T.Model -> ( T.Model, Cmd T.Msg )
update msg model =
  case msg of
    T.SetAuthor author ->
      ( { model | author = author }, Cmd.none )

    T.SetText text ->
      ( { model | text = text }, Cmd.none )

    {- On ENTER keydown -}
    T.KeyDown key ->
      if key == 13 then
        ( model, post model )
      else
        ( model, Cmd.none )

    T.Submit ->
      ( model, post model )

    T.SubmitHandler ( Ok res ) ->
      ( T.Model "" "", Cmd.none )

    T.SubmitHandler ( Err _ ) ->
      ( model, Cmd.none )

    _ ->
      ( model, Cmd.none )


{- See: http://stackoverflow.com/a/40114176 and http://package.elm-lang.org/packages/elm-community/html-extra/latest/Html-Events-Extra#onEnter -}
onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
  on "keydown" (Decode.map tagger keyCode)


-- OPERATIONS ------------------------------------------------------------------


resourceUrl : String
resourceUrl =
  "/api/comments"


post : T.Model -> Cmd T.Msg
post model =
  let
    body    = model |> postEncoder |> Http.jsonBody
    request = Http.post resourceUrl body postResponseDecoder
  in
    Http.send T.SubmitHandler request


-- VIEW ------------------------------------------------------------------------


view : T.Model -> Html T.Msg
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
                ] []
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
                ] []
            ]
        , div [ class "form-group text-right" ]
            [ button
                [ class "btn btn-primary"
                , onClick T.Submit
                ] [ text "Submit" ]
            ]
        ]
    ]
