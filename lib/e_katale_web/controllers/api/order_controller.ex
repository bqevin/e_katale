defmodule EKataleWeb.OrderController do
    use EKataleWeb, :controller
    alias EKatale.Orders.{OrderItem, OrderManager}
    import EKatale.Utils, only: [atomize_map_keys: 1]
    action_fallback EKataleWeb.FallbackController
    
    def add_to_cart(conn, params) do
      with {:ok, %OrderItem{} = order_item} <- OrderManager.add_order_item(atomize_map_keys(params)) do
        conn
        |> put_status(:created)
        |> render("order_item.json", item: order_item)
      end
    end
end