defmodule Bmb.ProductRecommendations do
  use Ecto.Schema

  schema "product_recommendations" do
    belongs_to :product, Bmb.Product
    belongs_to :recommended_product, Bmb.Product

    timestamps()
  end
end
