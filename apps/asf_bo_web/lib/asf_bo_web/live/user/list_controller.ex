defmodule AsfBOWeb.Live.User.ListController do
  use AsfBOWeb, :live_view

  alias Asf.Accounts

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        page_title: "Users",
        users: []
      )

    {:ok, socket}
  end

  def handle_params(_params, _url, socket) do
    users = Accounts.list_non_admin_users()
    socket = assign(socket, users: users)
    {:noreply, socket}
  end

  def empty_values(value) when value in [nil, ""], do: "/"
  def empty_values(value), do: value
end
