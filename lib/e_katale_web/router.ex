defmodule EKataleWeb.Router do
  use EKataleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug EKataleWeb.Auth.Pipeline
  end

  scope "/", EKataleWeb do
    pipe_through :api

    # users endpoints
    post("/users/signin", UserController, :signin)
    post("/users/signup", UserController, :create)

    # category endoints
    get("/categories", CategoryController, :index)
    get("/categories/:id", CategoryController, :show)
    
    # products endpoints
    get("/products", ProductController, :index)
    get("/products/:id", ProductController, :show)

    # require authentication for all endpoints below
    # pipe_through [:auth]
  end

  scope "/admin", EKataleWeb do
    pipe_through [:api, :auth]

    # categories endpoints
    post("/categories", CategoryController, :create)
    put("/categories/:id", CategoryController, :update)
    delete("/categories/:id", CategoryController, :delete)

    # products endpoints
    post("/products", ProductController, :create)
    put("/products/:id", ProductController, :update)
  end
end
 