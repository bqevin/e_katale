defmodule EKataleWeb.ProductControllerTest do
  use EKataleWeb.ConnCase

  alias EKatale.Inventory
  alias EKatale.Inventory.Product

  @create_attrs %{category_id: 42, description: "some description", image_url: "some image_url", name: "some name", quantity: 42, unit_price: 120.5}
  @update_attrs %{category_id: 43, description: "some updated description", image_url: "some updated image_url", name: "some updated name", quantity: 43, unit_price: 456.7}
  @invalid_attrs %{category_id: nil, description: nil, image_url: nil, name: nil, quantity: nil, unit_price: nil}

  def fixture(:product) do
    {:ok, product} = Inventory.create_product(@create_attrs)
    product
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get conn, product_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      conn = post conn, product_path(conn, :create), product: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, product_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category_id" => 42,
        "description" => "some description",
        "image_url" => "some image_url",
        "name" => "some name",
        "quantity" => 42,
        "unit_price" => 120.5}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, product_path(conn, :create), product: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product" do
    setup [:create_product]

    test "renders product when data is valid", %{conn: conn, product: %Product{id: id} = product} do
      conn = put conn, product_path(conn, :update, product), product: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, product_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category_id" => 43,
        "description" => "some updated description",
        "image_url" => "some updated image_url",
        "name" => "some updated name",
        "quantity" => 43,
        "unit_price" => 456.7}
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put conn, product_path(conn, :update, product), product: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete conn, product_path(conn, :delete, product)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, product_path(conn, :show, product)
      end
    end
  end

  defp create_product(_) do
    product = fixture(:product)
    {:ok, product: product}
  end
end
