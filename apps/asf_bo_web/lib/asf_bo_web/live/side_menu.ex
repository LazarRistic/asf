defmodule AsfBOWeb.Live.SideMenu do
  use AsfBOWeb, :live_view_with_out_flash

  alias Asf.Accounts

  def mount(_params, session, socket) do
    if connected?(socket), do: Accounts.subscribe

    not_confirmed_users = _get_not_confirmed_users()

    socket =
      assign(socket,
        current_user: session["current_user"],
        current_path: session["current_path"],
        is_open?: false,
        not_confirmed_users: not_confirmed_users
      )

    {:ok, socket}
  end

  def handle_event("toggle_menu", _, socket) do
    {:noreply, assign(socket, is_open?: !socket.assigns.is_open?)}
  end

  def handle_info({:user_created, _user}, socket) do
    not_confirmed_users = _get_not_confirmed_users()
    socket =
      assign(socket,
        not_confirmed_users: not_confirmed_users
      )

    {:noreply, socket}
  end

  def get_classes_dependent_of_path(:dashboard, "/"), do: "text-gray-700 bg-gray-100"

  def get_classes_dependent_of_path(:documents, "/documents" <> _),
    do: "text-gray-700 bg-gray-100"

  def get_classes_dependent_of_path(:admin_users, "/users/admin"),
    do: "text-gray-700 bg-gray-100"

  def get_classes_dependent_of_path(:users, "/users/regular"),
    do: "text-gray-700 bg-gray-100"

  def get_classes_dependent_of_path(:new_user, "/users/new"),
    do: "text-gray-700 bg-gray-100"

  def get_classes_dependent_of_path(_, _),
    do: "hover:text-gray-700 text-gray-300 hover:bg-gray-100"

  defp _get_not_confirmed_users() do
    Accounts.list_non_admin_users
    |> Enum.reduce(0, fn
        %{confirmed_at: nil}, acc -> acc + 1
        _, acc -> acc
      end)
  end
end
