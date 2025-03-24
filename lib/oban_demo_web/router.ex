defmodule ObanDemoWeb.Router do
  use ObanDemoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ObanDemoWeb do
    pipe_through :api

    post "/accounts", AccountController, :create

    get "/oban_jobs", JobMonitorController, :index
    get "/oban_jobs/:id", JobMonitorController, :show
    put "/oban_jobs/:id/cancel", JobMonitorController, :cancel
  end
end
