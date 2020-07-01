defmodule EKatale.Orders.OrderManager do
    import Ecto.Query, warn: false
    import Ecto.UUID
    alias EKatale.Repo
    alias EKatale.Orders.{Order, OrderItem}
    alias EKatale.Users
    alias EKatale.Inventory
    alias EKatale.Utils

    # params: product id, userid, quantity, unit_price, total, order_id 
    def add_order_item(params) do
        case params.order_id do
            nil ->
                create_new_order(params.user_id)
                |> create_order_item(params)

            order_id -> 
                create_order_item(params)
        end
    end

    defp create_new_order(user_id) do
        %Order{}
        |> Order.changeset(%{user_id: user_id})
        |> Repo.insert()
        |> case do
            {:ok, order} -> Utils.drop_meta_data(order)
            _ -> {:error, "order creation failed"}
        end
    end

    defp create_order_item(order, params) do  
        item = order_item(params)
        with {:ok, id} <- dump(order.id) do
            %OrderItem{}
            |> OrderItem.changeset(Map.put(item, :order_id, id))
            |> Repo.insert() 
        end  
    end

    defp create_order_item(params) do
        item = order_item(params)
        %OrderItem{}
        |> OrderItem.changeset(Map.put(item, :order_id, params.order_id))
        |> Repo.insert()
    end

    defp order_item(params) do
        total = params.quantity * params.unit_price
        %{
            unit_price: params.unit_price,
            total: total,
            product_id: params.product_id,
            quantity: params.quantity
        }
    end
    
    # TODO Update order total and product quantity when item is added to cart
end