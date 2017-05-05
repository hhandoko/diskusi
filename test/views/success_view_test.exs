###
# File     : success_view_test.exs
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
defmodule Diskusi.SuccessViewTest do
  @moduledoc """
  Success response view template unit tests.
  """

  use Diskusi.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  alias Diskusi.SuccessView

  test "renders 200.json" do
    expected = render_to_string(SuccessView, "200.json", [])
    response = render_json_response()

    assert expected == response
  end

  test "renders 201.json" do
    message  = "Comment successfully created"
    expected = render_to_string(SuccessView, "201.json", %{message: message})
    response = render_json_response(message)

    assert expected == response
  end

  test "render any other" do
    expected = render_to_string(SuccessView, "205.json", [])
    response = render_json_response()

    assert expected == response
  end

  # Convenience method to render a successful JSON response.
  defp render_json_response(), do: "{\"success\":true}"
  defp render_json_response(msg) do
    "{\"success\":true,\"message\":\"#{msg}\"}"
  end
end
