defmodule Bmb.CategoryResolver do
  alias Bmb.Repo
  alias Bmb.Category
  import Ecto.Query

  def get_parent_categories(_parent, _args, _ctx) do
    query =
      from c in Category,
        where: c.active == true and c.parent_id == 0,
        select: c

    {:ok, Repo.all(query)}
  end

  def get_categories_by_parent_id(_parent, %{parent_id: parent_id}, _ctx) do
    query =
      from c in Category,
        where: c.active == true and c.parent_id == ^parent_id,
        select: c

    {:ok, Repo.all(query)}
  end
end
