defmodule EKatale.Orders.Order do
    use Ecto.Schema
    import Ecto.Changeset
    alias EKatale.Users.User
    alias EKatale.Orders.OrderItem


    @doc false
    @primary_key {:id, :binary_id, autogenerate: true}
    schema "orders" do
        field :delivery_address, :string
        field :total, :integer
        belongs_to :user, User
        timestamps()
    end

    def changeset(order, attrs \\ %{}) do
        order
        |> cast(attrs, [:total, :delivery_address, :user_id])
        |> validate_required([:user_id])
    end
end