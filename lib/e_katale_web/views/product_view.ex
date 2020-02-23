defmodule EKataleWeb.ProductView do
  use EKataleWeb, :view
  alias EKataleWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      name: product.name,
      description: product.description,
      quantity: product.quantity,
      unit_price: product.unit_price,
      image_url: product.image_url,
      category_id: product.category_id}
  end
end
