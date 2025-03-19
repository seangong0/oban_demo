defmodule ObanDemo.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ObanDemo.Accounts` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some_email#{System.unique_integer([:positive])}@example.com"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        name: "some name"
      })
      |> ObanDemo.Accounts.create_user()

    user
  end
end
