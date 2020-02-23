defmodule EKataleWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use EKataleWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(EKataleWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(EKataleWeb.ErrorView, :"404")
  end

  def call(conn, {:error, :unauthorised}) do
    conn
    |> put_status(:unauthorised)
    |> render(EKataleWeb.ErrorView, :"401")
  end
end
