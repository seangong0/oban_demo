# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :oban_demo,
  ecto_repos: [ObanDemo.Repo],
  generators: [timestamp_type: :utc_datetime_usec]

config :oban_demo, ObanDemo.Repo,
  migration_primary_key: [name: :id, type: :binary_id],
  migration_foreign_key: [column: :id, type: :binary_id],
  migration_timestamps: [type: :utc_datetime_usec]

# config Oban
config :oban_demo, Oban,
  engine: Oban.Engines.Basic,
  queues: [
    # 默认队列
    default: 10,
    # 邮件队列
    emails: 5,
    # 高优先级队列
    critical: 1
  ],
  repo: ObanDemo.Repo,
  prefix: "oban"

config :swoosh, :api_client, false

# Configures the endpoint
config :oban_demo, ObanDemoWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: ObanDemoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ObanDemo.PubSub,
  live_view: [signing_salt: "N4AphO5WrW8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
env = config_env()

if "#{env}.exs" |> Path.expand(__DIR__) |> File.exists?() do
  import_config "#{env}.exs"

  if "#{env}.secret.exs" |> Path.expand(__DIR__) |> File.exists?() do
    import_config "#{env}.secret.exs"
  end
end
