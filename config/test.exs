use Mix.Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :asf, Asf.Repo,
  username: "postgres",
  password: "postgres",
  database: "asf_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :asf_web, AsfWeb.Endpoint,
  http: [port: 4002],
  server: false

config :asf_bo_web, AsfBOWeb.Endpoint,
  http: [port: 4012],
  server: false

config :asf_fh_web, AsfFHWeb.Endpoint,
  http: [port: 4022],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
