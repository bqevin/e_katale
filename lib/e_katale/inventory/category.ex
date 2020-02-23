defmodule EKatale.Inventory.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias EKatale.Inventory.Product


  schema "categories" do
    field :description, :string
    field :name, :string
    has_many :products, Product
    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
