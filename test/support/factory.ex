###
# File     : factory.ex
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
defmodule Diskusi.Factory do
  @moduledoc """
  Factory module to help generate test data.

  Based on the [ex_machina](https://github.com/thoughtbot/ex_machina) library.
  """

  use ExMachina.Ecto, repo: Diskusi.Repo

  @doc """
  Create a new comment fixture for testing.
  """
  def comment_factory do
    %Diskusi.Comment{
      author: "Alex Bell",
      text: "Hello world!"
    }
  end
end
