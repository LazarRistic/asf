defmodule AsfWeb.PageController do
  use AsfWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
