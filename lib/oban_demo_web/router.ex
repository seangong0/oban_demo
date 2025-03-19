defmodule ObanDemoWeb.Router do
  use ObanDemoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ObanDemoWeb do
    pipe_through :api
  end
end
