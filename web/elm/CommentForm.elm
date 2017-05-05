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


-- MODEL -----------------------------------------------------------------------


type alias Model =
  { author : String
  , text : String
  }


type Msg
  = NoOp
  | SetAuthor String
  | SetText String
  | KeyDown Int
  | SubmitComment
  | SubmitCommentHandler (Result Http.Error SubmitResponse)


type alias SubmitResponse =
  { success : Bool
  , message : String
  }


emptyForm : Model
emptyForm =
  Model "" ""


submitResponseDecoder : Decode.Decoder SubmitResponse
submitResponseDecoder =
  Decode.map2 SubmitResponse
    (Decode.field "success" Decode.bool)
    (Decode.field "message" Decode.string)


submitEncoder : Model -> Encode.Value
submitEncoder model =
  Encode.object
    [ ("comment", commentEncoder model) ]


commentEncoder : Model -> Encode.Value
commentEncoder model =
  Encode.object
    [ ("author", Encode.string model.author)
    , ("text", Encode.string model.text)
    ]


-- UPDATE ----------------------------------------------------------------------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SetAuthor author ->
      ( { model | author = author }, Cmd.none )

    SetText text ->
      ( { model | text = text }, Cmd.none )

    {- On ENTER keydown -}
    KeyDown key ->
      if key == 13 then
        ( model, post model )
      else
        ( model, Cmd.none )

    SubmitComment ->
      ( model, post model )

    SubmitCommentHandler ( Ok res ) ->
      ( Model "" "", Cmd.none )

    SubmitCommentHandler ( Err _ ) ->
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


post : Model -> Cmd Msg
post model =
  let
    body    = model |> submitEncoder |> Http.jsonBody
    request = Http.post resourceUrl body submitResponseDecoder
  in
    Http.send SubmitCommentHandler request


-- VIEW ------------------------------------------------------------------------


view : Model -> Html Msg
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
                , onInput SetAuthor
                , onKeyDown KeyDown
                ] []
            ]
        , div [ class "form-group" ]
            [ label [ for "text" ] [ text "Comment" ]
            , textarea
                [ id "text"
                , class "form-control"
                , rows 6
                , Html.Attributes.value model.text
                , onInput SetText
                , onKeyDown KeyDown
                ] []
            ]
        , div [ class "form-group text-right" ]
            [ button
                [ class "btn btn-primary"
                , onClick SubmitComment
                ] [ text "Submit" ]
            ]
        ]
    ]
