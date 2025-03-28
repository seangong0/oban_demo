import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :oban_demo, ObanDemo.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "oban_demo_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# config Oban
config :oban_demo, Oban, testing: :manual
# We don't run a server during test. If one is required,
# you can enable the server option below.
config :oban_demo, ObanDemoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "QPnsNXOI-eBm8kmCCn4KdB3tSy2rau1Ia9lkYgXIFjPsKAqiKJpjsv0TpLktdmnL",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :oban_demo, ObanDemo.Mailer, adapter: Swoosh.Adapters.Test
