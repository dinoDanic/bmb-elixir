defmodule Graphql.Types.Product do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  import_types(BmbWeb.Graphql.Scalars.Decimal)

  node object(:product) do
    field(:name, :string)
    field(:display_name, :string)
    field(:price, :decimal)
    field(:price_neto, :string, resolve: &ProductResolver.price_neto/3)
    field(:hrk_price, :string, resolve: &ProductResolver.hrk_price/3)
    field(:hrk_price_neto, :string, resolve: &ProductResolver.hrk_price_neto/3)
    field(:meta_title, :string)
    field(:meta_description, :string)
    field(:meta_keyword, :string)
    field(:ean, :string)
    field(:weight, :integer)
    field(:firebox, :string)
    field(:height, :string)
    field(:work_board, :string)
    field(:active, :boolean)
    field(:recommendations, list_of(:product), resolve: &ProductResolver.recommendations/3)
    field(:description, :description, resolve: &ProductResolver.description/3)
  end
end
