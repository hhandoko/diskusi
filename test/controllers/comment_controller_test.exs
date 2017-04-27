###
# File     : comment_controller_test.exs
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
defmodule Diskusi.CommentControllerTest do
  @moduledoc """
  Comment controller unit tests.
  """

  use Diskusi.ConnCase
  alias Diskusi.CommentView

  test "#index renders a list comments" do
    conn    = build_conn()
    comment = insert(:comment)

    conn    = get(conn, comment_path(conn, :index))

    assert json_response(conn, 200) == render_json(CommentView, "index.json", comments: [comment])
  end

  test "#show renders a single comment" do
    conn    = build_conn()
    comment = insert(:comment)

    conn    = get(conn, comment_path(conn, :show, comment))

    assert json_response(conn, 200) == render_json(CommentView, "show.json", comment: comment)
  end
end
