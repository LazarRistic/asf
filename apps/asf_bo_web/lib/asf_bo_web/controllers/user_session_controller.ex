defmodule AsfBOWeb.UserSessionController do
  use AsfBOWeb, :controller

  alias Asf.Accounts
  alias AsfBOWeb.UserAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil, page_title: "Sing In")
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    case Accounts.get_user_by_email_and_password(email, password) do
      nil ->
        render(conn, "new.html", error_message: "Invalid email or password")

      %{roles: ["admin"]} = user ->
        UserAuth.log_in_user(conn, user, user_params)

      _ ->
        conn
        |> put_flash(:error, "You do not have rights to access this page.")
        |> render("new.html", error_message: nil)
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
