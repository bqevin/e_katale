defmodule EKataleWeb.CategoryController do
  use EKataleWeb, :controller

  alias EKatale.Inventory
  alias EKatale.Inventory.Category

  action_fallback EKataleWeb.FallbackController

  def index(conn, _params) do
    categories = Inventory.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def create(conn, category_params) do
    with {:ok, %Category{} = category} <- Inventory.create_category(category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", category_path(conn, :show, category))
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Inventory.get_category!(id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Inventory.get_category!(id)

    with {:ok, %Category{} = category} <- Inventory.update_category(category, category_params) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Inventory.get_category!(id)
    with {:ok, %Category{}} <- Inventory.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
