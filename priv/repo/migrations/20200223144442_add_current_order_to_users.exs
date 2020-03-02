defmodule EKatale.Repo.Migrations.AddCurrentOrderToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:current_order_id, references(:orders, type: :uuid))
    end
  end
end
