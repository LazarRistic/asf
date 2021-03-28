defmodule AsfWeb.Live.TopMenu do
  use AsfWeb, :live_view

  def mount(_params, session, socket) do
    socket =
      assign(socket,
        current_user: session["current_user"],
        is_open?: false
      )

    {:ok, socket}
  end

  def handle_event("toggle_menu", _, socket) do
    {:noreply, assign(socket, is_open?: !socket.assigns.is_open?)}
  end
end
