defmodule ObanDemoWeb.JobMonitorJSONTest do
  use ExUnit.Case, async: true

  alias Oban.Job
  import ObanDemoWeb.JobMonitorJSON

  @job %Job{
    id: 123,
    state: "available",
    args: %{"user_id" => 1},
    worker: "ObanDemo.Worker",
    queue: "default",
    inserted_at: ~U[2024-01-01 00:00:00Z]
  }

  describe "render/2" do
    test "index.json renders job list" do
      assert render("index.json", %{jobs: [@job, @job]}) == %{
               data: [
                 %{
                   id: 123,
                   state: "available",
                   args: %{"user_id" => 1},
                   worker: "ObanDemo.Worker",
                   queue: "default",
                   inserted_at: ~U[2024-01-01 00:00:00Z]
                 },
                 %{
                   id: 123,
                   state: "available",
                   args: %{"user_id" => 1},
                   worker: "ObanDemo.Worker",
                   queue: "default",
                   inserted_at: ~U[2024-01-01 00:00:00Z]
                 }
               ]
             }
    end

    test "show.json renders a single job" do
      assert render("show.json", %{job: @job}) == %{
               id: 123,
               state: "available",
               args: %{"user_id" => 1},
               worker: "ObanDemo.Worker",
               queue: "default",
               inserted_at: ~U[2024-01-01 00:00:00Z]
             }
    end
  end
end
