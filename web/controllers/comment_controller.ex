###
# File     : comment_controller.ex
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
defmodule Diskusi.CommentController do
  @moduledoc """
  Comment controller.
  """

  use Diskusi.Web, :controller
  use Monad.Operators
  alias Diskusi.Comment
  alias Diskusi.ErrorView
  import Monad.Result, only: [success?: 1, success: 1, error: 1]


  @doc """
  GET `/api/comments`

  Returns all comments result as JSON, or an empty result array if not found.
  """
  @spec index(Plug.Conn.t, map) :: Plug.Conn.t
  def index(conn, _params) do
    comments = Repo.all(Comment)

    conn
    |> render("index.json", comments: comments)
  end

  @doc """
  GET `/api/comments/:id`

  Returns a comment result as JSON for the given ID, or 404 if not found.
  """
  @spec show(Plug.Conn.t, map) :: Plug.Conn.t
  def show(conn, %{"id" => id}) do
    case Repo.get(Comment, id) do
      comment = %Comment{} ->
        conn
        |> render("show.json", comment: comment)

      _ ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", %{})
    end
  end

  @doc """
  POST `/api/comments`

  Returns a success response if comment is successfully created.
  """
  @spec create(Plug.Conn.t, map) :: Plug.Conn.t
  def create(conn, %{"comment" => comment_params}) do
    result = success(comment_params)
             ~>> fn p  -> link_reply_to_id(p)  end
             ~>> fn p  -> create_changeset(p)  end
             ~>> fn cs -> assert_changeset(cs) end
             ~>> fn cs -> insert_changeset(cs) end

    if success?(result) do
      conn
      |> put_status(201)
      |> render("created.json", %{message: "Comment added", comment: result.value})
    else
      conn
      |> put_status(400)
      |> render(ErrorView, "400.json", result)
    end
  end

  # Link :reply_ref with :reply_to ID on %Comment{}.
  #
  # We try to capture three possible outcomes, but return a `success()` value regardless, as we would like to delegate
  # validations at the changeset layer.
  #
  # For example, if :reply_ref is provided but no record is resolved, we return success with `reply_to: -1` which
  # represents an invalid database PK. Calling `Repo.insert()` will throw an error since `foreign_key_constraint()` is
  # enforced.
  @spec link_reply_to_id(map) :: Monad.Result.t
  defp link_reply_to_id(comment_params) do
    if Map.has_key?(comment_params, "reply_ref") do
      id =
        case Repo.get_by(Comment, ref: comment_params["reply_ref"]) do
          %Comment{id: id} -> id
          _                -> -1
        end

      comment_params
      |> Map.put("reply_to", id)
      |> success
    else
      comment_params
      |> success
    end
  end

  # Shorthand to create the changeset
  @spec create_changeset(map) :: Monad.Result.t
  defp create_changeset(comment_params), do: success(Comment.changeset(%Comment{}, comment_params))

  # Assert the changeset for field formatting and value bounds error.
  @spec assert_changeset(Ecto.Changeset.t) :: Monad.Result.t
  defp assert_changeset(changeset) do
    case changeset.valid? do
      true -> changeset |> success
      _    -> changeset |> error
    end
  end

  # Insert / persist the changeset (record).
  #
  # We can expect an error since `foreign_key_constraint()` validation is only thrown during `Repo.insert()`.
  @spec insert_changeset(Ecto.Changeset.t) :: Monad.Result.t
  defp insert_changeset(changeset) do
    case Repo.insert(changeset) do
      {:ok, record} -> record |> success
      {:error, _}   -> changeset |> error
    end
  end
end
