defmodule EKataleWeb.UserController do
  use EKataleWeb, :controller

  alias EKatale.Users
  alias EKatale.Users.User
  alias EKataleWeb.Auth.Guardian
  alias EKataleWeb.ErrorView

  action_fallback EKataleWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
        conn
        |> put_status(:created)
        |> render("user.json", %{user: user, token: token})
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    else
      {:error, :unauthorised} -> 
        conn
        |> put_status(401)
        |> render(ErrorView, "401.json", %{errors: "Email/Password mismatch"})
    end
  end
end
