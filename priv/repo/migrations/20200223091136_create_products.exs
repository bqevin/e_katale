defmodule EKatale.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :quantity, :integer
      add :unit_price, :float
      add :image_url, :string
      add :category_id, references(:categories)
      timestamps()
    end

  end
end
