defmodule Bmb.ProductResolver do
  alias Bmb.ProductRecommendations
  alias Bmb.{Product, Category, ProductCategory, Description}
  alias Absinthe.Relay.Connection
  import Ecto.Changeset
  alias Bmb.Repo
  import Ecto.Query
  alias Bmb.ProductCategory

  def all_products(_root, %{category_id: category_id} = args, _info) do
    # TODO: if no category id throws and error
    products =
      from(p in Product,
        join: c in assoc(p, :category),
        where: c.id == ^category_id,
        order_by: p.id
      )
      |> Connection.from_query(&Repo.all/1, default_pagination(args))
  end

  def all_active_products(_root, _args, _info) do
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

  defp default_pagination(%{:last => _} = data), do: data

  defp default_pagination(data), do: Map.put_new(data, :first, 1000)
end
