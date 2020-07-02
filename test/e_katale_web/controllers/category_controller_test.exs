defmodule EKataleWeb.CategoryControllerTest do
  use EKataleWeb.ConnCase

  alias EKatale.Inventory
  alias EKatale.Inventory.Category

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:category) do
    {:ok, category} = Inventory.create_category(@create_attrs)
    category
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all categories", %{conn: conn} do
      conn = get(conn, "/categories")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create category" do
    @tag :auth
    test "renders category when data is valid", %{conn: conn} do
      conn = post(conn, "/admin/categories", @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, category_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name"}
    end

    @tag :auth
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, "/admin/categories", @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update category" do
    setup [:create_category]

    @tag :auth
    test "renders category when data is valid", %{conn: conn, category: %Category{id: id} = category} do
      conn = put(conn, "/admin/categories/#{id}", %{category: @update_attrs})
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, "/categories/#{id}")
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name"}
    end

    @tag :auth
    test "renders errors when data is invalid", %{conn: conn, category: %Category{id: id} = category} do
      conn = put(conn, "/admin/categories/#{id}", %{category: @invalid_attrs})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete category" do
    setup [:create_category]

    @tag :auth
    test "deletes chosen category", %{conn: conn, category: %Category{id: id} = category} do
      conn = delete(conn, "/admin/categories/#{id}")
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get(conn, "/categories/#{id}")
      end
    end
  end

  defp create_category(_) do
    category = fixture(:category)
    {:ok, category: category}
  end
end
