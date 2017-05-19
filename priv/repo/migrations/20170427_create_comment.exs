###
# File     : 20170427_create_comment.exs
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
defmodule Diskusi.Repo.Migrations.CreateComment do
  @moduledoc """
  Create comment table migration script.
  """

  use Ecto.Migration

  def change do
    create_if_not_exists table(:comment) do
      add :ref,      :uuid,    null: false
      add :author,   :string,  null: false
      add :text,     :string,  null: false
      add :level,    :integer, null: false, default: 0
      add :reply_to, references(:comment, on_delete: :delete_all)

      timestamps()
    end

    create_if_not_exists unique_index(:comment, [:ref])
  end
end
