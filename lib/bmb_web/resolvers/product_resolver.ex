defmodule Bmb.ProductResolver do
  alias Bmb.{Product, Category, ProductCategory}
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

  def get_products_by_category_id(_root, %{category_id: category_id}, _info) do
    products =
      from(p in Product,
        join: pc in ProductCategory,
        on: p.id == pc.product_id,
        join: c in Category,
        on: c.id == pc.category_id,
        where: c.id == ^category_id and p.active == true,
        select: p,
        distinct: true
      )
      |> Repo.all()

    {:ok, products}
  end

end
