defmodule AsfWeb.Live.TopMenu do
  use AsfWeb, :live_view

  def mount(_params, session, socket) do
    socket =
      assign(socket,
        current_user: session["current_user"]
      )

    {:ok, socket}
  end
end
