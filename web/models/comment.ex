###
# File     : comment.ex
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
defmodule Diskusi.Comment do
  @moduledoc """
  Comment model.
  """

  use Diskusi.Web, :model

  # NOTE: Disable dialyzer warnings for changeset
  @dialyzer {:nowarn_function, changeset: 1}

  schema "comment" do
    field :author, :string
    field :text, :string

    timestamps()
  end

  @doc """
  Creates a changeset based on the `model` and `params`.
  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(author text))
    |> validate_required([:author, :text])
  end
end
