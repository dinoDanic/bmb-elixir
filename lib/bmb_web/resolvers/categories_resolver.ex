defmodule Bmb.CategoryResolver do
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

def add_image_to_category(_root, %{image_url: image_url, category_id: category_id}, _info) do
  input = %{image: image_url}

  case Bmb.Repo.get(Bmb.Category, category_id) do
    nil ->
      {:error, "Category not found"}

    category ->
      changeset = Bmb.Category.changeset(category, input)

      case Bmb.Repo.update(changeset) do
        {:ok, updated_category} ->
          {:ok, updated_category}

        {:error, _changeset} ->
          {:error, "Failed to update category"}
      end
  end
end
end
