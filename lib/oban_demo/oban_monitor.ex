defmodule ObanDemo.ObanMonitor do
  import Ecto.Query

  def list_job(filters \\ []) do
    user_id = Keyword.get(filters, :user_id)

    oban_config()
    |> Oban.Repo.all(build_query(user_id))
  end

  defp build_query(nil) do
    from(j in Oban.Job,
      order_by: [desc: j.inserted_at]
    )
  end

  defp build_query(user_id) do
    from(j in Oban.Job,
      order_by: [desc: j.inserted_at],
      where: j.args["user_id"] == ^user_id
    )
  end

  def get_job!(id) do
    oban_config()
    |> Oban.Repo.get!(Oban.Job, id)
  end

  def cancel_job(id) do
    id
    |> get_job!()
    |> Oban.cancel_job()
  end

  defp oban_config, do: Oban.config(Oban)
end
