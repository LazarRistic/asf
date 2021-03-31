defmodule AsfBOWeb.Live.SideMenu do
  use AsfBOWeb, :live_view

  def mount(_params, session, socket) do
    socket =
      assign(socket,
        current_user: session["current_user"],
        current_path: session["current_path"],
        is_open?: false
      )

    {:ok, socket}
  end

  def handle_event("toggle_menu", _, socket) do
    {:noreply, assign(socket, is_open?: !socket.assigns.is_open?)}
  end

  def get_classes_dependent_of_path(:dashboard, "/"), do: "text-gray-700 bg-gray-100"

  def get_classes_dependent_of_path(:documents, "/documents" <> _),
    do: "text-gray-700 bg-gray-100"

  def get_classes_dependent_of_path(_, _),
    do: "hover:text-gray-700 text-gray-300 hover:bg-gray-100"
end
