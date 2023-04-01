defmodule Bmb.ProductResolver do
  alias Bmb.Product
  alias Bmb.Repo
  import Ecto.Query

  def all_products(_root, _args, _info) do
    products =
      Product
      |> where(active: true)
      |> Repo.all()

    {:ok, products}
  end

  def get_product_by_id(_root, %{id: id}, _info) do
    product = Repo.get(Product, id)

    case product do
      nil ->
        {:error, "Product not found"}

      _ ->
        {:ok, product}
    end
  end
end
