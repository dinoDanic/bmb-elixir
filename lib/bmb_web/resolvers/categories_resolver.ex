defmodule Bmb.CategoryResolver do
  alias Bmb.Image
  alias Bmb.CategoryImages
  alias Bmb.Repo
  alias Bmb.Category
  import Ecto.Query

  def get_categories(_parent, _args, _ctx) do
    query =
      from(c in Category,
        where: c.active == true and c.parent_id == 0,
        select: c
      )

    {:ok, Repo.all(query)}
  end

  def get_all_categories(_parent, _args, _ctx) do
    query =
      from(c in Category,
        where: c.active == true,
        select: c
      )

    {:ok, Repo.all(query)}
  end

  def get_childrens(category, _args, _ctx) do
    query =
      from(c in Category,
        where: c.active == true and c.parent_id == ^category.id,
        select: c
      )

    {:ok, Repo.all(query)}
  end

  def get_category_by_id(_root, %{id: id}, _info) do
    category = Repo.get(Category, id)

    case category do
      nil ->
        {:error, "category not found"}

      _ ->
        {:ok, category}
    end
  end

  def images(product, _, _) do
    images =
      from(c in Bmb.Category,
        join: ci in Bmb.CategoryImages,
        on: c.id == ci.product_id,
        join: i in Bmb.Image,
        on: i.id == ci.image_id,
        where: c.id == ^product.id,
        select: %{id: i.id, url: i.url, is_main: ci.is_main}
      )
      |> Bmb.Repo.all()

    case images do
      nil ->
        {:ok, nil}

      _ ->
        {:ok, images}
    end
  end

  def add_category_image_url(
        _parent,
        %{category_id: category_id, image_url: image_url, category_name: category_name},
        _info
      ) do
    case get_image_by_name(category_name) do
      nil ->
        image = %Image{url: image_url, name: category_name}

        case Bmb.Repo.insert(image) do
          {:ok, inserted_image} ->
            is_main =
              Bmb.Repo.one(from(p in Bmb.CategoryImages, where: p.category_id == ^category_id)) ==
                nil

            category_image = %CategoryImages{
              category_id: String.to_integer(category_id),
              image_id: inserted_image.id,
              is_main: is_main
            }

            case Bmb.Repo.insert(category_image) do
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

  defp get_image_by_name(category_name) do
    Bmb.Image
    |> where([i], i.name == ^category_name)
    |> Bmb.Repo.one()
  end
end
