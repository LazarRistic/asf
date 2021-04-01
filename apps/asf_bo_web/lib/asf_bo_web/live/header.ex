defmodule AsfBOWeb.Live.Header do
  use AsfBOWeb, :live_view

  def mount(_params, session, socket) do
    current_user = session["current_user"]
    socket = assign(socket, current_user: current_user)
    {:ok, socket}
  end
end
