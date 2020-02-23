defmodule EKataleWeb.UserController do
  use EKataleWeb, :controller

  alias EKatale.Users
  alias EKatale.Users.User
  alias EKataleWeb.Auth.Guardian

  action_fallback EKataleWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
        conn
        |> put_status(:created)
        |> render("user.json", %{user: user, token: token})
    end
  end

  # def signin(conn, params) do
    
  # end
end
