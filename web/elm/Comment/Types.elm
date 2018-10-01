------
-- File     : Comment/Types.elm
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


module Comment.Types exposing (..)

import Date exposing (Date)
import Http
import Json.Decode as Decode
import Json.Decode.Extra as DecodeX
import Json.Encode as Encode


-- COMMENT (MODEL) -------------------------------------------------------------


type alias Model =
  { ref : Uuid
  , author : String
  , text : String
  , level : Int
  , created : Date
  , updated : Date
  , show_reply_form : Bool
  }


type alias Uuid =
  String


type alias FormModel =
  { reply_to : Uuid
  , author : String
  , text : String
  }



-- GET (FETCH ALL) RESPONSE ----------------------------------------------------------


type alias FetchAllResponse =
  { success : Bool
  , results : List Model
  }


commentResponseDecoder : Decode.Decoder FetchAllResponse
commentResponseDecoder =
  Decode.map2 FetchAllResponse
    (Decode.field "success" Decode.bool)
    (Decode.field "results" <| Decode.list commentDecoder)


commentDecoder : Decode.Decoder Model
commentDecoder =
  Decode.map7 Model
    (Decode.field "ref" Decode.string)
    (Decode.field "author" Decode.string)
    (Decode.field "text" Decode.string)
    (Decode.field "level" Decode.int)
    (Decode.field "created" DecodeX.date)
    (Decode.field "updated" DecodeX.date)
    (Decode.succeed False)



-- POST RESPONSE ---------------------------------------------------------------


type alias PostResponse =
  { success : Bool
  , message : String
  , result : Model
  }


postResponseDecoder : Decode.Decoder PostResponse
postResponseDecoder =
  Decode.map3 PostResponse
    (Decode.field "success" Decode.bool)
    (Decode.field "message" Decode.string)
    (Decode.field "result" commentDecoder)


postEncoder : FormModel -> Encode.Value
postEncoder model =
  Encode.object
    [ ( "comment", formModelEncoder model ) ]


formModelEncoder : FormModel -> Encode.Value
formModelEncoder model =
  Encode.object
    [ ( "reply_to", Encode.string model.reply_to )
    , ( "author", Encode.string model.author )
    , ( "text", Encode.string model.text )
    ]



-- MESSAGES --------------------------------------------------------------------


type Msg
  = NoOp
    --
  | FetchAll
  | FetchAllHandler (Result Http.Error FetchAllResponse)
    --
  | ShowReplyForm Uuid
    --
  | SetAuthor String
  | SetText String
  | KeyDown Int
  | Submit
  | SubmitHandler (Result Http.Error PostResponse)
