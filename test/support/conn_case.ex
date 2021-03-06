defmodule Classlab.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """
  alias Plug.ProcessStore

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      use Bamboo.Test

      alias Classlab.Repo
      alias Classlab.Factory
      alias Classlab.Session

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import Classlab.Router.Helpers
      import Classlab.AssignUserPlug, only: [current_user: 1]

      # The default endpoint for testing
      @endpoint Classlab.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Classlab.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Classlab.Repo, {:shared, self()})
    end

    opts = Plug.Session.init(store: ProcessStore, key: "foobar")
    conn =
      Phoenix.ConnTest.build_conn()
      |> Plug.Session.call(opts)
      |> Plug.Conn.fetch_session()

    {:ok, conn: conn}
  end
end
