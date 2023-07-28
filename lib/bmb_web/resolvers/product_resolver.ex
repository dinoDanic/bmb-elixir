defmodule Bmb.ProductResolver do
  alias Bmb.ProductRecommendations
  alias Bmb.{Product, Category, ProductCategory, Description}
  alias Absinthe.Relay.Connection
  import Ecto.Changeset
  alias Bmb.Repo
  import Ecto.Query

  def all_products(_root, args, _info) do
    query =
      from(p in Product,
        order_by: p.id
      )

    query =
      case Map.get(args, :category_ids) do
        nil ->
          query

        category_ids ->
          from(q in query,
            join: pc in assoc(q, :product_categories),
            join: c in assoc(pc, :category),
            where: c.id in ^category_ids
          )
      end

    query =
      case Map.get(args, :name) do
        nil ->
          query

        name ->
          from(q in query,
            where: ilike(q.display_name, ^"%#{name}%")
          )
      end

    query =
      case Map.get(args, :active) do
        nil ->
          query

        active ->
          from(q in query,
            where: q.active == ^active
          )
      end

    query |> Connection.from_query(&Repo.all/1, default_pagination(args))
  end

  def all_active_products(_root, _args, _info) do
    products =
      Product
      |> where(active: true)
      |> Repo.all()

    {:ok, products}
  end

  def get_product_by_id(_root, %{id: id}, _info) do
    # decoded_id = Base.decode64!(id)
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

  def get_products_by_category_name(_root, %{category_name: category_name}, _info) do

    products =
      from(p in Product,
        join: pc in ProductCategory,
        on: p.id == pc.product_id,
        join: c in Category,
        on: c.id == pc.category_id,
        where: c.name == ^category_name and p.active == true,
        select: p,
        distinct: true
      )
      |> Repo.all()

    {:ok, products}
  end

  def price_with_tax(product, _args, _ctx) do
    tax_percentage = 25

    price_with_tax =
      Decimal.mult(product.price, Decimal.add(100, Decimal.new(tax_percentage)))
      |> Decimal.div(100)

    {:ok, price_with_tax}
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

    case description do
      nil -> nil
      _ -> {:ok, description}
    end
  end

  def update_product(product, name) do
    product
    |> Ecto.Changeset.change(name)
  end

  def save_product(product) do
    case Repo.update(product) do
      {:ok, updated_product} ->
        updated_product

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def edit_product(_parent, %{id: id, input: input}, _info) do
    input =
      if not is_nil(Map.get(input, :price)),
        do: Map.put(input, :price, Decimal.new(input[:price])),
        else: input

    Repo.get(Product, id)
    |> change(input)
    |> Repo.update()
  end

  def category(product, _, _) do
    category =
      from(p in Bmb.Product,
        join: pc in Bmb.ProductCategory,
        on: p.id == pc.product_id,
        join: c in Bmb.Category,
        on: c.id == pc.category_id,
        where: p.id == ^product.id,
        select: c
      )
      |> Bmb.Repo.one()

    {:ok, category}
  end

  def add_recommendation(
        _parent,
        %{product_id: product_id, recommended_product_id: recommended_product_id},
        _info
      ) do
    input = %ProductRecommendations{
      product_id: String.to_integer(product_id),
      recommended_product_id: String.to_integer(recommended_product_id)
    }

    case Bmb.Repo.insert(input) do
      {:ok, inserted_recommendation} ->
        {:ok, inserted_recommendation}

      {:error, _} ->
        {:error, "Failed to add recommendation"}
    end
  end

  def remove_recommendation(
        _parent,
        %{product_id: product_id, recommended_product_id: recommended_product_id},
        _info
      ) do
    query =
      from(pr in Bmb.ProductRecommendations,
        where:
          pr.product_id == ^String.to_integer(product_id) and
            pr.recommended_product_id == ^String.to_integer(recommended_product_id)
      )

    case Bmb.Repo.delete_all(query) do
      {:ok, 1} ->
        {:ok, true}

      {:ok, 0} ->
        {:error, false}

      {:error, _} ->
        {:error, false}

      {_count, extra} ->
        {:error, extra}
    end
  end

  def get_recommendations(_parent, _args, _info) do
    case Bmb.Repo.all(Bmb.ProductRecommendations) do
      recommendations when is_list(recommendations) ->
        {:ok, recommendations}

      _ ->
        {:error, "Failed to fetch recommendations"}
    end
  end

  defp default_pagination(%{:last => _} = data), do: data

  defp default_pagination(data), do: Map.put_new(data, :first, 1000)
end
