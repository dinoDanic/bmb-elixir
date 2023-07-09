defmodule Bmb.FeaturedProductResolver do
  alias Bmb.Repo
  alias Bmb.FeaturedProduct
  alias Bmb.Product
  import Ecto.Query

  def get_featured_products(_parent, _args, _ctx) do
    query =
      from(fp in FeaturedProduct,
        join: p in Product,
        on: fp.product_id == p.id,
        select: p
      )

    result = Repo.all(query)
    {:ok, result}
  end
end
