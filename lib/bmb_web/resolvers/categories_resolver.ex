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

  def get_childrens(category, _args, _ctx) do
    query =
      from(c in Category,
        where: c.active == true and c.parent_id == ^category.id,
        select: c
      )

    {:ok, Repo.all(query)}
  end
end
