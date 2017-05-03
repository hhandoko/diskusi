###
# File     : error_view.ex
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
defmodule Diskusi.ErrorView do
  @moduledoc """
  Error view templates.
  """

  use Diskusi.Web, :view

  @doc """
  Render 404 page not found error as HTML.
  """
  @spec render(String.t, map) :: any
  def render("404.html", _assigns) do
    "Page not found"
  end

  @doc """
  Render 404 resource not found error as JSON response.
  """
  def render("404.json", _assigns) do
    %{success: false, errors: %{message: "Resource not found"}}
  end

  @doc """
  Render 500 internal server error as HTML.
  """
  def render("500.html", _assigns) do
    "Internal server error"
  end

  @doc """
  Render 500 internal server error as JSON response.
  """
  def render("500.json", _assigns) do
    %{success: false, errors: %{message: "Internal server error"}}
  end

  @doc """
  Error template fallback. Render 500 error when no render clause matches
  or no template is found.
  """
  # NOTE: typespec omitted due to dialyzer warnings on overlapping domains
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
