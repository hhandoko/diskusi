###
# File     : test.exs
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
use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :diskusi, Diskusi.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :diskusi, Diskusi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "diskusi_user",
  password: "S3cret!",
  hostname: "192.168.10.20",
  database: "diskusi_data_test",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox
