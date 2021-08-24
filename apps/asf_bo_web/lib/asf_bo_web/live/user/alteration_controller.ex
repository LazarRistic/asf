defmodule AsfBOWeb.Live.User.AlterationController do
  use AsfBOWeb, :live_view

  alias Asf.Repo
  alias Asf.Accounts
  alias Asf.Accounts.{User, UserToken}
  alias AsfFHWeb.Assets

  import Ecto.Changeset

  def mount(_params, _session, socket) do
    user = %User{}
    email_changeset = User.email_changeset(user, %{})
    password_changeset = User.password_changeset(user, %{})
    info_changeset = User.info_changeset(user, %{})
    roles_changeset = User.roles_changeset(user, %{})
    avatar_changeset = User.avatar_changeset(user, %{})

    socket =
      socket
      |> assign(
        page_title: "Edit",
        show_multi_select_roles: false,
        show_confirmation: true,
        send_confirmation: false,
        user: user,
        email_changeset: email_changeset,
        password_changeset: password_changeset,
        info_changeset: info_changeset,
        roles_changeset: roles_changeset,
        avatar_changeset: avatar_changeset,
        email_expanded: false,
        password_expanded: false,
        info_expanded: false,
        roles_expanded: false,
        avatar_expanded: false
      )
      |> allow_upload(
        :avatar,
        accept: ~w(.png .jpeg .jpg),
        max_entries: 1,
        max_file_size: 8_000_000,
        auto_upload: false
      )
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    username = params["username"]
    user = Accounts.get_user_by_username(username)

    email_changeset = User.email_changeset(user, %{})
    password_changeset = User.password_changeset(user, %{})
    info_changeset = User.info_changeset(user, %{})
    roles_changeset = User.roles_changeset(user, %{})
    avatar_changeset = User.avatar_changeset(user, %{})

    socket =
      assign(socket,
        page_title: "Edit #{user.username}",
        user: user,
        email_changeset: email_changeset,
        password_changeset: password_changeset,
        info_changeset: info_changeset,
        roles_changeset: roles_changeset,
        avatar_changeset: avatar_changeset
      )

    {:noreply, socket}
  end

  def handle_event("toggle_email", _, socket) do
    socket = assign(socket, email_expanded: !socket.assigns.email_expanded)
    {:noreply, socket}
  end

  def handle_event("toggle_password", _, socket) do
    socket = assign(socket, password_expanded: !socket.assigns.password_expanded)
    {:noreply, socket}
  end

  def handle_event("toggle_info", _, socket) do
    socket = assign(socket, info_expanded: !socket.assigns.info_expanded)
    {:noreply, socket}
  end

  def handle_event("toggle_roles", _, socket) do
    socket = assign(socket, roles_expanded: !socket.assigns.roles_expanded)
    {:noreply, socket}
  end

  def handle_event("toggle_avatar", _, socket) do
    socket = assign(socket, avatar_expanded: !socket.assigns.avatar_expanded)
    {:noreply, socket}
  end

  def handle_event("avatar_changed", params, socket) do
    IO.inspect(params, label: "PARAMS")
    {:noreply, socket}
  end

  def handle_event("create_user", %{"user" => user_params} = params, socket) do

    [url | _] =
      consume_uploaded_entries(socket, :avatar, fn meta, entry ->
        AsfFHWeb.Assets.insert_avatar(meta, entry)
      end)

    user_params =
      Map.put(user_params, "avatar_url", url)

    send_confirmation =
      case user_params do
        %{"roles" => ["admin"]} ->
          false
        _ ->
          socket.assigns.send_confirmation
      end

    socket =
      case (changeset = User.registration_changeset(%User{}, user_params)).valid? do
        false ->
          changeset = Map.put(changeset, :action, :insert)

          assign(socket,
            changeset: changeset
          )

        true ->
          case Accounts.register_user(user_params) do
            {:ok, user} ->
              {:ok, _} =
                if send_confirmation in [true, "true"] do
                  Accounts.deliver_user_confirmation_instructions(user, &Routes.user_confirmation_url(socket, :confirm, &1))
                else
                  _confirm_user(user)
                end

              socket
              |> put_flash(:info, "User created successfully.")
              |> _redirect(user)

            {:error, %Ecto.Changeset{} = changeset} ->
              assign(socket,
                changeset: changeset
              )
          end
      end

    {:noreply, socket}
  end

  def handle_event("user_changed", %{"user" => %{"roles" => ["admin"]} = user_params}, socket) do
    changeset = User.registration_changeset(%User{}, user_params)
    {:noreply,
      assign(socket,
        show_confirmation: false,
        send_confirmation: false,
        changeset: changeset
      )
    }
  end

  def handle_event("user_changed", %{"user" => user_params, "_target" => ["user", "roles"]}, socket) do
    changeset = User.registration_changeset(%User{}, user_params)
    {:noreply,
      assign(socket,
        show_confirmation: true,
        changeset: changeset
      )
    }
  end

  def handle_event("user_changed", %{"_target" => ["send_confirmation"], "send_confirmation" => "true"}, socket) do
    {:noreply,
      assign(socket,
        send_confirmation: true
      )
    }
  end

  def handle_event("user_changed", %{"_target" => ["send_confirmation"]}, socket) do
    {:noreply,
      assign(socket,
        send_confirmation: false
      )
    }
  end

  def handle_event("user_changed", params, socket) do
    IO.inspect(params, label: "PARAMS", limit: :infinity, pretty: true)
    {:noreply, socket}
  end

  def handle_event("show_roles", _, socket) do
    socket =
      assign(socket,
        show_multi_select_roles: true
      )
    {:noreply, socket}
  end

  defp _confirm_user(user) do
    {encoded_token, user_token} = UserToken.build_email_token(user, "confirm")
    Repo.insert!(user_token)
    Accounts.confirm_user(encoded_token)
  end

  defp _redirect(socket, %{roles: ["admin"]}), do: push_redirect(socket, to: Routes.live_path(socket, AsfBOWeb.Live.User.AdminListController))
  defp _redirect(socket, _), do: push_redirect(socket, to: Routes.live_path(socket, AsfBOWeb.Live.User.ListController))
end
