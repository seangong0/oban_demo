defmodule ObanDemoWeb.JobMonitorControllerTest do
  use ObanDemoWeb.ConnCase

  setup %{conn: conn} do
    user_id = Ecto.UUID.generate()

    {:ok, job} =
      %{user_id: user_id}
      |> Oban.Job.new(queue: :default, worker: ObanDemo.Worker)
      |> Oban.insert()

    conn = put_req_header(conn, "accept", "application/json")
    %{conn: conn, job: job, user_id: user_id}
  end

  describe "GET /api/oban_jobs" do
    test "Returns all jobs without filtering", %{conn: conn, job: %{id: job_id}, user_id: user_id} do
      conn = get(conn, ~p"/api/oban_jobs")

      assert [
               %{
                 "id" => ^job_id,
                 "state" => "available",
                 "args" => %{"user_id" => ^user_id},
                 "queue" => "default",
                 "worker" => "ObanDemo.Worker"
               }
             ] =
               json_response(conn, 200)["data"]
    end

    test "Returns matching jobs with user_id filtering", %{
      conn: conn,
      job: %{id: job_id},
      user_id: user_id
    } do
      conn = get(conn, ~p"/api/oban_jobs?user_id=#{user_id}")
      assert [%{"id" => ^job_id}] = json_response(conn, 200)["data"]
    end
  end

  describe "GET /api/oban_jobs/:id" do
    test "Gets an existing job", %{conn: conn, job: %{id: job_id}} do
      conn = get(conn, ~p"/api/oban_jobs/#{job_id}")
      assert %{"id" => ^job_id} = json_response(conn, 200)
    end

    test "Returns 404 when getting a non-existent job", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        get(conn, ~p"/api/oban_jobs/0")
      end
    end
  end

  describe "POST /api/oban_jobs/:id/cancel" do
    test "Successfully cancels a job", %{conn: conn, job: %{id: job_id}} do
      conn = put(conn, ~p"/api/oban_jobs/#{job_id}/cancel")
      assert %{"state" => "cancelled"} = json_response(conn, 200)
    end
  end
end
