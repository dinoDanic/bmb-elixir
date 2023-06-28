defmodule Bmb.ProductResolver do
  alias Bmb.ProductImages
  alias Bmb.Image
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

  def images(product, _, _) do
    images =
      from(p in Bmb.Product,
        join: pi in Bmb.ProductImages,
        on: p.id == pi.product_id,
        join: i in Bmb.Image,
        on: i.id == pi.image_id,
        where: p.id == ^product.id,
        select: %{id: i.id, url: i.url, is_main: pi.is_main}
      )
      |> Bmb.Repo.all()

    case images do
      nil ->
        {:ok, nil}

      _ ->
        {:ok, images}
    end
  end

  def add_product_image_url(
        _parent,
        %{product_id: product_id, image_url: image_url, product_name: product_name},
        _info
      ) do
    case get_image_by_name(product_name) do
      nil ->
        image = %Image{url: image_url, name: product_name}

        case Bmb.Repo.insert(image) do
          {:ok, inserted_image} ->
            is_main =
              Bmb.Repo.one(from(p in Bmb.ProductImages, where: p.product_id == ^product_id)) ==
                nil

            product_image = %ProductImages{
              product_id: String.to_integer(product_id),
              image_id: inserted_image.id,
              is_main: is_main
            }

            case Bmb.Repo.insert(product_image) do
              {:ok, _} ->
                {:ok, "Image added"}

              {:error, _} ->
                {:error, "Something went wrong"}
            end

          {:error, _} ->
            {:error, "Something went wrong"}
        end

      _ ->
        {:error, "Product name already exists"}
    end
  end

  defp get_image_by_name(product_name) do
    Bmb.Image
    |> where([i], i.name == ^product_name)
    |> Bmb.Repo.one()
  end

  def remove_product_image_url(_parent, %{product_id: product_id, image_id: image_id}, _info) do
    product_image =
      from(p in Bmb.ProductImages,
        where: p.product_id == ^product_id and p.image_id == ^image_id,
        preload: [:product, :image]
      )
      |> Bmb.Repo.one()

    case product_image do
      nil ->
        {:error, "Product image not found"}

      %Bmb.ProductImages{product: _product, image: _image} ->
        case Bmb.Repo.delete(product_image) do
          {:ok, delete_product_image} ->
            image = %Image{id: delete_product_image.image_id}

            case Bmb.Repo.delete(image) do
              {:ok, _} ->
                {:ok, "Image deleted"}

              {:error, _} ->
                {:error, "Failed to remove image"}
            end

          {:error, _} ->
            {:error, "Failed to remove product image"}
        end
    end
  end

  def set_main_image(_parent, %{product_id: product_id, image_id: image_id}, _info) do
    # Reset is_main for all images of the product to false

    from(p in Bmb.ProductImages,
      where: p.product_id == ^product_id,
      update: [set: [is_main: false]]
    )
    |> Bmb.Repo.update_all([])

    from(p in Bmb.ProductImages,
      where: p.product_id == ^product_id and p.image_id == ^image_id,
      update: [set: [is_main: true]]
    )
    |> Bmb.Repo.update_all([])

    {:ok, "updated"}
  end

  defp default_pagination(%{:last => _} = data), do: data

  defp default_pagination(data), do: Map.put_new(data, :first, 1000)
end
