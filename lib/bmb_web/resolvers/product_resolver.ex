defmodule Bmb.ProductResolver do
  alias Bmb.ProductRecommendations
  alias Bmb.{Product, Category, ProductCategory, Description}
  alias Absinthe.Relay.Connection
  import Ecto.Changeset
  alias Bmb.Repo
  import Ecto.Query
  alias Bmb.ProductCategory

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
          from q in query,
            join: pc in assoc(q, :product_categories),
            join: c in assoc(pc, :category),
            where: c.id in ^category_ids
      end

    query =
      case Map.get(args, :name) do
        nil ->
          query

        name ->
          from q in query,
            where: ilike(q.display_name, ^"%#{name}%")
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

    # |> Ecto.Changeset.cast_assoc(:recommendations)
  end

  def save_product(product) do
    case Repo.update(product) do
      {:ok, updated_product} ->
        updated_product

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  # TODO move decimal to scalars *.API.Graphql.Scalars.Decimal
  # defmodule *.API.Graphql.Scalars.Decimal do
  #   use Absinthe.Schema.Notation

  #   scalar :decimal do
  #     parse(fn
  #       %{value: value}, _ ->
  #         Decimal.parse(value)

  #       # Temporary fix when decimal field isn't sent from the client.
  #       # TODO: Fix to skip the field if field isn't sent.
  #       %Absinthe.Blueprint.Input.Null{}, _ ->
  #         {:ok, Decimal.new(0)}

  #       _, _ ->
  #         :error
  #     end)

  #     serialize(&to_string/1)
  #   end
  # end

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

  def image_url(product, _, _) do
    image =
      from(p in Bmb.Product,
        join: pi in Bmb.ProductImages,
        on: p.id == pi.product_id,
        join: i in Bmb.Image,
        on: i.id == pi.image_id,
        where: p.id == ^product.id and pi.is_main == true,
        select: i
      )
      |> Bmb.Repo.one()

    case image do
      nil ->
        {:ok, nil}

      _ ->
        {:ok, image.url}
    end
  end

  defp default_pagination(%{:last => _} = data), do: data

  defp default_pagination(data), do: Map.put_new(data, :first, 1000)
end
