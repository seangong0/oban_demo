defmodule ObanDemo.Workers.EmailWorkerTest do
  use ObanDemo.DataCase, async: true
  use Oban.Testing, repo: ObanDemo.Repo

  alias ObanDemo.Workers.EmailWorker

  test "send welcome email" do
    {:ok, %{id: user_id}} =
      ObanDemo.Accounts.create_user(%{name: "test", email: "test@example.com"})

    assert :ok =
             perform_job(EmailWorker, %{"user_id" => user_id})
  end

  test "send welcome email with invalid user" do
    fake_user_id = Ecto.UUID.generate()

    assert {:error, reason} = perform_job(EmailWorker, %{"user_id" => fake_user_id})
    assert reason =~ "User #{fake_user_id} not found"
  end
end
