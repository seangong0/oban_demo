defmodule ObanDemoWeb.AccountController do
  use ObanDemoWeb, :controller

  alias ObanDemo.Accounts

  def create(conn, user_params) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
