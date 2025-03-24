defmodule ObanDemoWeb.JobMonitorController do
  use ObanDemoWeb, :controller

  alias ObanDemo.ObanMonitor

  def index(conn, params) do
    jobs = ObanMonitor.list_job(user_id: params["user_id"])
    render(conn, "index.json", jobs: jobs)
  end

  def show(conn, %{"id" => id}) do
    job = ObanMonitor.get_job!(id)
    render(conn, "show.json", job: job)
  end

  def cancel(conn, %{"id" => id}) do
    ObanMonitor.cancel_job(id)
    job = ObanMonitor.get_job!(id)
    render(conn, "show.json", job: job)
  end
end
