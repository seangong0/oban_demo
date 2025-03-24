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
end
