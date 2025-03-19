defmodule ObanDemo.Workers.EmailWorker do
  require Logger
  use Oban.Worker, queue: :emails, max_attempts: 3

  alias ObanDemo.Accounts
  alias ObanDemo.Mailer
  alias ObanDemo.UserEmail

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"user_id" => user_id}}) do
    user_id
    |> Accounts.get_user!()
    |> UserEmail.welcome()
    |> Mailer.deliver()
    |> case do
      {:ok, _} ->
        :ok

      {:error, reason} ->
        Logger.error("Failed to send email: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
