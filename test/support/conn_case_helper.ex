###
# File     : conn_case_helper.ex
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
defmodule Diskusi.ConnCaseHelper do

  @doc """
  Render template for the given view as JSON.
  """
  def render_json(view, template, assigns) do
    template
    |> view.render(assigns)
    |> format_json
  end

  @doc """
  Serialize and deserialize the JSON data.
  """
  defp format_json(data) do
    data
    |> Poison.encode!
    |> Poison.decode!
  end
end
