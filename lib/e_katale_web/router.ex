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

    # category endoints
    get("/categories", CategoryController, :index)
    post("/categories", CategoryController, :create)
    get("/categories/:id", CategoryController, :show)
    put("/categories/:id", CategoryController, :update)
    
    # products endpoints
    get("/products", ProductController, :index)
    post("/products", ProductController, :create)
    get("/products/:id", ProductController, :show)
    put("products/:id", ProductController, :update)
  end

  scope "/api", EKataleWeb do
    pipe_through [:api, :auth]
  end
end
 