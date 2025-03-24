defmodule ObanDemo.ObanMonitorTest do
  use ObanDemo.DataCase, async: true

  setup do
    user_id = Ecto.UUID.generate()

    {:ok, job} =
      %{user_id: user_id}
      |> Oban.Job.new(queue: :default, worker: ObanDemo.Worker)
      |> Oban.insert()

    %{user_id: user_id, job: job}
  end

  describe "list_job/1" do
    test "Returns all jobs without filtering" do
      jobs = ObanDemo.ObanMonitor.list_job()
      assert length(jobs) >= 1
    end

    test "Returns matching jobs when filtering by user_id", %{job: job, user_id: user_id} do
      {:ok, _another_job} =
        %{user_id: Ecto.UUID.generate()}
        |> Oban.Job.new(queue: :default, worker: ObanDemo.Worker)
        |> Oban.insert()

      jobs = ObanDemo.ObanMonitor.list_job(user_id: user_id)
      assert [found] = jobs
      assert found.id == job.id
    end
  end

  describe "get_job!/1" do
    test "Gets an existing job", %{job: job} do
      assert ObanDemo.ObanMonitor.get_job!(job.id).id == job.id
    end
  end

  describe "cancel_job/1" do
    test "Successfully cancels a job", %{job: job} do
      assert :ok = ObanDemo.ObanMonitor.cancel_job(job.id)
    end
  end
end
