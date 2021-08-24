use Mix.Config

# Configure your database
config :asf, Asf.Repo,
  username: "postgres",
  password: "postgres",
  database: "asf_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :asf_web, AsfWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../apps/asf_web/assets", __DIR__)
    ]
  ]

config :asf_bo_web, AsfBOWeb.Endpoint,
  http: [port: 4010],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../apps/asf_bo_web/assets", __DIR__)
    ]
  ]

config :asf_fh_web, AsfFHWeb.Endpoint,
  http: [port: 4020],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../apps/asf_fh_web/assets", __DIR__)
    ]
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :asf_web, AsfWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/asf_web/(live|views)/.*(ex)$",
      ~r"lib/asf_web/templates/.*(eex)$"
    ]
  ]

config :asf_bo_web, AsfBOWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/asf_bo_web/(live|views)/.*(ex)$",
      ~r"lib/asf_bo_web/templates/.*(eex)$"
    ]
  ]

config :asf_fh_web, AsfFHWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/asf_fh_web/(live|views)/.*(ex)$",
      ~r"lib/asf_fh_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20
