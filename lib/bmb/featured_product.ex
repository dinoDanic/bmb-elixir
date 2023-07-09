defmodule Bmb.FeaturedProduct do
  use Ecto.Schema

  schema "featured_products" do
    field :product_id, :id
    timestamps()
  end
end
