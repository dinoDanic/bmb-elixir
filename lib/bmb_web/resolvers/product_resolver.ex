defmodule Bmb.ProductResolver do
  alias Bmb.ProductRecommendations
  alias Bmb.{Product, Category, ProductCategory, Description}
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

  def price_neto(product, _args, _ctx) do
    price = Decimal.to_float(product.price)
    newPrice = (price / 1.25) |> Float.round(2) |> Float.to_string()
    # formattedPrice = Kernel.inspect(newPrice, limit: :infinity) 

    {:ok, newPrice}
  end

  def hrk_price(product, _args, _ctx) do
    price = Decimal.to_float(product.price)
    newPrice = (price * 7.53450) |> Float.round(2) |> Float.to_string()

    {:ok, newPrice}
  end

  def hrk_price_neto(product, _args, _ctx) do
    price = Decimal.to_float(product.price)
    newPrice = (price * 7.53450 / 1.25) |> Float.round(2) |> Float.to_string()

    {:ok, newPrice}
  end

  def recommendations(product, _args, _info) do
    query =
      from(r in ProductRecommendations,
        where: r.product_id == ^product.id,
        join: p in Product,
        on: r.recommended_product_id == p.id,
        select: p
      )

    {:ok, Repo.all(query)}
  end

  def description(%{description_id: description_id}, _args, _ctx) do
    query =
      from(d in Description,
        where: d.id == ^description_id,
        select: d
      )

    description = Repo.one(query)
    {:ok, description}
  end
end
