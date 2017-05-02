###
# File     : page_controller_test.exs
# License  :
#   Copyright (c) 2017 Herdy Handoko
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
###
defmodule Diskusi.PageControllerTest do
  @moduledoc """
  Static page controller unit tests.
  """

  use Diskusi.ConnCase

  test "`GET /` renders the landing page", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Get Started"
  end
end
