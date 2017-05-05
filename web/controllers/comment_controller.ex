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
  alias Diskusi.Comment
  alias Diskusi.ErrorView
  alias Diskusi.SuccessView

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
    changeset = Comment.changeset(%Comment{}, comment_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_status(201)
      |> render(SuccessView, "201.json", %{message: "Comment added"})
    else
      conn
      |> put_status(400)
      |> render(ErrorView, "400.json", changeset)
    end
  end
end
