defmodule Bmb.ProductCategory do
  use Ecto.Schema

  schema "products_categories" do
    belongs_to :product, Bmb.Product
    belongs_to :category, Bmb.Category

    timestamps()
  end
end
