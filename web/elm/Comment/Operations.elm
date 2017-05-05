------
-- File     : Comment/Operations.elm
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


module Comment.Operations exposing (..)

import Http
import Comment.Types as T


resourceUrl : String
resourceUrl =
  "/api/comments"


fetchAll : Cmd T.Msg
fetchAll =
  let
    request =
      Http.get resourceUrl T.commentResponseDecoder
  in
    Http.send T.FetchAllHandler request


post : T.Model -> Cmd T.Msg
post model =
  let
    body =
      model |> T.postEncoder |> Http.jsonBody

    request =
      Http.post resourceUrl body T.postResponseDecoder
  in
    Http.send T.SubmitHandler request
