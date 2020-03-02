defmodule EKatale.Orders.OrderItem do
    use Ecto.Schema
    import Ecto.Changeset
    alias EKatale.Orders.Order
    alias EKatale.Inventory.Product

    schema "order_items" do
        field :unit_price, :integer
        field :quantity, :integer
        field :total, :integer
        field :order_id, Ecto.UUID
        field :product_id, :integer
        timestamps()
    end

    @fields [
        :unit_price,
        :quantity,
        :total,
        :product_id,
        :order_id
    ]

    def changeset(order_item, attrs \\ %{}) do
        order_item
        |> cast(attrs, @fields)
        |> validate_required(@fields)
    end
end