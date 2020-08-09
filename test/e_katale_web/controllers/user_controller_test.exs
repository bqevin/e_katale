defmodule EKataleWeb.UserControllerTest do
  use EKataleWeb.ConnCase

  alias EKatale.Users
  alias EKatale.Users.User

  @create_attrs %{
    address: "some address", 
    email: "email@email.com", 
    first_name: "some first_name", 
    last_name: "some last_name", 
    phone_number: "+256700900800", 
    password: "password"
  }
  @invalid_attrs %{address: nil, email: nil, first_name: nil, last_name: nil, phone_number: nil}

  def fixture(:user) do
    {:ok, user} = Users.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, "/users/signup", %{user: @create_attrs})
      assert conn.status == 201
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, "users/signup", %{user: @invalid_attrs})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "signin user" do
    setup [:create_user]

    test "return user token after signin", %{conn: conn, user: %User{email: email, password: password}} do
      conn = post(conn, "/users/signin", %{email: email, password: password})
      response = json_response(conn, 201)
      assert "token" in Map.keys(response)
    end

    test "renders errors when signin credentials are invalid", %{conn: conn, user: %User{email: email}} do
      conn = post(conn, "/users/signin", %{email: email, password: "fakepassword"})
      assert json_response(conn, 401) == %{"code" => 401, "error" => "Email/Password mismatch"}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
