defmodule EKatale.Repo.Migrations.CreateOrderItemTable do
  use Ecto.Migration

  def change do
    create table(:order_items, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:order_id, references(:orders, type: :uuid, on_delete: :delete_all))
      add(:product_id, references(:products, on_delete: :delete_all))
      add(:unit_price, :integer)
      add(:quantity, :integer)
      add(:total, :integer)
      timestamps()
    end

  end
end
