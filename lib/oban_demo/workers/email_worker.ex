defmodule ObanDemo.Workers.EmailWorker do
  require Logger
  use Oban.Worker, queue: :emails, max_attempts: 3

  alias ObanDemo.Accounts
  alias ObanDemo.Mailer
  alias ObanDemo.UserEmail

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"user_id" => user_id}}) do
    case Accounts.get_user(user_id) do
      nil ->
        {:error, "User #{user_id} not found"}

      user ->
        send_welcome_email(user)
    end
  end

  defp send_welcome_email(user) do
    user
    |> UserEmail.welcome()
    |> Mailer.deliver()
    |> handle_email_delivery()
  end

  defp handle_email_delivery({:ok, _}), do: :ok

  defp handle_email_delivery({:error, reason}) do
    Logger.error("Failed to send email: #{inspect(reason)}")
    {:error, reason}
  end
end
