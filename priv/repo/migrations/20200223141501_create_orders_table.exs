defmodule EKatale.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all, type: :integer))
      add(:delivery_address, :string)
      add(:total, :integer, default: 0)
      timestamps()
    end
  end
end
