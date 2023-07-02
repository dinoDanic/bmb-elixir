defmodule Graphql.Types.FeaturedProduct do
  use Absinthe.Schema.Notation
  object(:featured_product) do
    field(:product_id, :id)
  end
end
