defmodule ObanDemo.Accounts.User do
  use ObanDemo.Schema

  schema "users" do
    field :name, :string
    field :email, :string

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
