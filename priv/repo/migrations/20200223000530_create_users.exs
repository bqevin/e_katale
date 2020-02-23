defmodule EKatale.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :phone_number, :string
      add :email, :string
      add :address, :string
      add :encrypted_password, :string

      timestamps()
    end

  end
end

