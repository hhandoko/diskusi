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
  alias Diskusi.Comment
  alias Diskusi.CommentView
  alias Diskusi.ErrorView

  test "`GET /api/comments` renders a list comments" do
    comment  = insert(:comment)
    conn     = build_conn()
    conn     = get(conn, comment_path(conn, :index))

    expected = json_response(conn, 200)
    response = render_json(CommentView, "index.json", comments: [comment])

    assert expected == response
  end

  test "`GET /api/comments` without results renders an empty results response" do
    conn     = build_conn()
    conn     = get(conn, comment_path(conn, :index))

    expected = json_response(conn, 200)
    response = render_json(CommentView, "index.json", comments: [])

    assert expected == response
  end

  test "`GET /api/comments/:id` renders a single comment" do
    comment  = insert(:comment)
    conn     = build_conn()
    conn     = get(conn, comment_path(conn, :show, comment))

    expected = json_response(conn, 200)
    response = render_json(CommentView, "show.json", comment: comment)

    assert expected == response
  end

  test "`GET /api/comments/:id` without results renders an empty result response with 404 status code" do
    comment  = %Comment{build(:comment) | id: 0}
    conn     = build_conn()
    conn     = get(conn, comment_path(conn, :show, comment))

    expected = json_response(conn, 404)
    response = render_json(ErrorView, "404.json", comment: comment)

    assert expected == response
  end
end
