###
# File     : error_view_test.exs
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
defmodule Diskusi.ErrorViewTest do
  @moduledoc """
  Error view template unit tests.
  """

  use Diskusi.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  alias Diskusi.ErrorView

  test "renders 400.json" do
    expected = render_to_string(ErrorView, "400.json", [])
    response = render_json_response("Validation error")

    assert expected == response
  end

  test "renders 404.html" do
    expected = render_to_string(ErrorView, "404.html", [])
    response = "Page not found"

    assert expected == response
  end

  test "renders 404.json" do
    expected = render_to_string(ErrorView, "404.json", [])
    response = render_json_response("Resource not found")

    assert expected == response
  end

  test "render 500.html" do
    expected = render_to_string(ErrorView, "500.html", [])
    response = "Internal server error"

    assert expected == response
  end

  test "renders 500.json" do
    expected = render_to_string(ErrorView, "500.json", [])
    response = render_json_response("Internal server error")

    assert expected == response
  end

  test "render any other" do
    expected = render_to_string(ErrorView, "505.html", [])
    response = "Internal server error"

    assert expected == response
  end

  # Convenience method to render a failed JSON response.
  defp render_json_response(msg) do
    "{\"success\":false,\"errors\":{\"message\":\"#{msg}\"}}"
  end
end
