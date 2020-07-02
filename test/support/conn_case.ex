defmodule EKataleWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  import EKatale.Factory

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import EKataleWeb.Router.Helpers
      import EKatale.Factory
      # The default endpoint for testing
      @endpoint EKataleWeb.Endpoint
    end
  end


  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EKatale.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(EKatale.Repo, {:shared, self()})
    end
    
    if tags[:auth] do
      user = insert(:user)

      {:ok, token, _claims} = EKataleWeb.Auth.Guardian.encode_and_sign(user)

      conn = Phoenix.ConnTest.build_conn() 
      |> Plug.Conn.put_req_header("authorization", "Bearer: " <> token)

      {:ok, conn: conn}
    else
      {:ok, conn: Phoenix.ConnTest.build_conn()}
    end
  end

end
