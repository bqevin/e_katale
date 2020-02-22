defmodule EKataleWeb.Router do
  use EKataleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EKataleWeb do
    pipe_through :api
  end
end
