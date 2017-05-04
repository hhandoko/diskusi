###
# File     : comment_view_test.exs
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
defmodule Diskusi.CommentViewTest do
  @moduledoc """
  Comment view template unit tests.
  """

  use Diskusi.ModelCase
  import Diskusi.Factory
  alias Diskusi.CommentView

  test "comment_json" do
    comment  = insert(:comment)

    expected = CommentView.comment_json(comment)
    response = %{
                 author: comment.author,
                 text: comment.text,
                 inserted_at: comment.inserted_at,
                 updated_at: comment.updated_at
               }

    assert expected == response
  end

  test "index.json" do
    comment  = insert(:comment)

    expected = CommentView.render("index.json", %{comments: [comment]})
    response = %{
                 success: true,
                 results: [CommentView.comment_json(comment)]
               }

    assert expected == response
  end

  test "show.json" do
    comment  = insert(:comment)

    expected = CommentView.render("show.json", %{comment: comment})
    response = %{
                 success: true,
                 result: CommentView.comment_json(comment)
               }

    assert expected == response
  end
end
