###
# File     : comment_test.exs
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
defmodule Diskusi.CommentTest do
  @moduledoc """
  Comment model unit tests.
  """

  use Diskusi.ModelCase
  alias Diskusi.Comment

  @valid_attrs %{author: "Alex Bell", text: "Hello World!"}

  test "valid changeset" do
    changeset = Comment.changeset(%Comment{}, @valid_attrs)

    assert changeset.valid?
  end

  test "changeset is invalid if author is empty" do
    invalid_attr = Map.delete(@valid_attrs, :author)

    expected     = {:author, "can't be blank"}
    result       = errors_on(%Comment{}, invalid_attr)

    assert expected in result
  end

  test "changeset is invalid if text is empty" do
    invalid_attr = Map.delete(@valid_attrs, :text)

    expected     = {:text, "can't be blank"}
    result       = errors_on(%Comment{}, invalid_attr)

    assert expected in result
  end
end
