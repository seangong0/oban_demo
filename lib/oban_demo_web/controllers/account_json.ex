defmodule ObanDemoWeb.AccountJSON do
  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      name: user.name
    }
  end
end
