###
# File     : config.exs
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
#
# Notes    :
#   This file is responsible for configuring your application
#   and its dependencies with the aid of the Mix.Config module.
#
#   This configuration file is loaded before any dependency and
#   is restricted to this project.
###
use Mix.Config

# General application configuration
config :diskusi,
  ecto_repos: [Diskusi.Repo]

# Configures the endpoint
config :diskusi, Diskusi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oBP+fiwqm4JQuMsq9tUbGx0w0SNRQUhTEFSbCbiBEkAykRUaJq92amPYWibKYty9",
  render_errors: [view: Diskusi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Diskusi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
