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

import Http


type alias Model =
  { author : String
  , text : String
  }


type alias FetchAllResponse =
  { success : Bool
  , results : List Model
  }


type alias PostResponse =
  { success : Bool
  , message : String
  }


type Msg
  = NoOp
    --
  | FetchAll
  | FetchAllHandler (Result Http.Error FetchAllResponse)
    --
  | SetAuthor String
  | SetText String
  | KeyDown Int
  | Submit
  | SubmitHandler (Result Http.Error PostResponse)
