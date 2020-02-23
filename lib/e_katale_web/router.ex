defmodule EKataleWeb.Router do
  use EKataleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug EKataleWeb.Auth.Pipeline
  end

  scope "/api", EKataleWeb do
    pipe_through :api

    # users endpoints
    post("/users/signin", UserController, :signin)
    post("/users/signup", UserController, :create)
  end

  scope "/api", EKataleWeb do
    pipe_through [:api, :auth]
  end
end
 