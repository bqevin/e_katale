defmodule EKatale.Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset


  schema "products" do
    field :category_id, :integer
    field :description, :string
    field :image_url, :string
    field :name, :string
    field :quantity, :integer
    field :unit_price, :float
    belongs_to :categories, Category
    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :quantity, :unit_price, :image_url, :category_id])
    |> validate_required([:name, :description, :quantity, :unit_price, :image_url, :category_id])
  end
end
