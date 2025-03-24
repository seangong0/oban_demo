defmodule ObanDemoWeb.JobMonitorJSON do
  def render("index.json", %{jobs: jobs}) do
    %{
      data: Enum.map(jobs, &job/1)
    }
  end

  def render("show.json", %{job: job}), do: job(job)

  defp job(%Oban.Job{} = job) do
    %{
      id: job.id,
      state: job.state,
      args: job.args,
      worker: job.worker,
      queue: job.queue,
      inserted_at: job.inserted_at
    }
  end
end
