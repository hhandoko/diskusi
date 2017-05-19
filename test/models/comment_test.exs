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
  alias Ecto.UUID

  @valid_attrs %{author: "Alex Bell", text: "Hello World!"}

  test "valid changeset" do
    changeset = Comment.changeset(%Comment{}, @valid_attrs)

    assert changeset.valid?
  end

  test "valid changeset with provided `ref`" do
    attr      = Map.put(@valid_attrs, :ref, UUID.generate())
    changeset = Comment.changeset(%Comment{}, attr)

    assert changeset.valid?
  end

  test "invalid changeset if `author` is empty" do
    invalid_attr = Map.delete(@valid_attrs, :author)

    expected     = {:author, "can't be blank"}
    result       = errors_on(%Comment{}, invalid_attr)

    assert expected in result
  end

  test "invalid changeset if `text` is empty" do
    invalid_attr = Map.delete(@valid_attrs, :text)

    expected     = {:text, "can't be blank"}
    result       = errors_on(%Comment{}, invalid_attr)

    assert expected in result
  end

  test "valid changeset with provided `level`" do
    attr      = Map.put(@valid_attrs, :level, 1)
    changeset = Comment.changeset(%Comment{}, attr)

    assert changeset.valid?
  end

  test "invalid changeset if `level` is a negative value" do
    invalid_attr = Map.put(@valid_attrs, :level, -1)

    expected     = {:level, "must be greater than or equal to 0"}
    result       = errors_on(%Comment{}, invalid_attr)

    assert expected in result
  end

  # NOTE: FK constraint validation happens only during `insert` or `update` invocation, so this changeset test will pass
  #       regardless of the `reply_to` value (e.g. negative value) as long as it is an integer.
  test "valid changeset with provided `reply_to`" do
    attr      = Map.put(@valid_attrs, :reply_to, 1)
    changeset = Comment.changeset(%Comment{}, attr)

    assert changeset.valid?
  end
end
