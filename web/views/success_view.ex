###
# File     : success_view.ex
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
defmodule Diskusi.SuccessView do
  @moduledoc """
  Success response view templates.
  """

  use Diskusi.Web, :view

  @doc """
  Render 200 OK as JSON response.
  """
  @spec render(String.t, map) :: any
  def render("200.json", _assigns) do
    %{success: true}
  end

  @doc """
  Render 201 resource created as JSON response.
  """
  def render("201.json", %{:message => message}) do
    %{success: true, message: message}
  end

  @doc """
  Success template fallback. Render 200 OK when no render clause matches
  or no template is found.
  """
  # NOTE: typespec omitted due to dialyzer warnings on overlapping domains
  def template_not_found(_template, assigns) do
    render("200.json", assigns)
  end
end
