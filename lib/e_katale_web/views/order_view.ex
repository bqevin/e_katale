defmodule EKataleWeb.OrderView do
    use EKataleWeb, :view
    alias EKatale.Utils

  def render("order_item.json", %{item: item}), do: Utils.drop_meta_data(item)
 
end
  