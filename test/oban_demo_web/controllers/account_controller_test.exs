defmodule ObanDemoWeb.AccountControllerTest do
  use ObanDemoWeb.ConnCase
  alias ObanDemo.Accounts

  describe "POST /api/accounts" do
    test "success", %{conn: conn} do
      params = %{
        "name" => "test",
        "email" => "test@example.com",
        "password" => "secret1234"
      }

      conn =
        conn
        |> put_req_header("accept", "application/json")
        |> post(~p"/api/accounts", params)

      assert response = json_response(conn, 201)
      assert %{"id" => id, "email" => email} = response
      assert email == params["email"]
      assert Accounts.get_user!(id)
    end
  end
end
