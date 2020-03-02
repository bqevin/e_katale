defmodule EKatale.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias EKatale.Orders.Order

  schema "users" do
    field :address, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    belongs_to :order, Order, foreign_key: :current_order_id, type: :binary_id

    timestamps()
  end

  @fields [:first_name, :last_name, :phone_number, :email, :address, :password]
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:current_order_id | @fields])
    |> validate_required(@fields)
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> put_hashed_password()
  end

  defp put_hashed_password(changeset) do
    case changeset do
    %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
      put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
    _ -> changeset  
    end
  end
end
