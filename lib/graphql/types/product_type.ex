defmodule Graphql.Types.Product do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  import_types(BmbWeb.Graphql.Scalars.Decimal)

  object(:product) do
    field(:name, :string)
    field(:id, :id)
    field(:display_name, :string)
    field(:price, :decimal)
    field(:price_with_tax, :string, resolve: &Bmb.ProductResolver.price_with_tax/3)
    field(:hrk_price, :string, resolve: &Bmb.ProductResolver.hrk_price/3)
    field(:hrk_price_neto, :string, resolve: &Bmb.ProductResolver.hrk_price_neto/3)
    field(:meta_title, :string)
    field(:meta_description, :string)
    field(:meta_keyword, :string)
    field(:ean, :string)
    field(:weight, :decimal)
    field(:firebox, :string)
    field(:work_board, :string)
    field(:instructions_download_url, :string)
    field(:image_url, :string)
    field(:active, :boolean)
    field(:recommendations, list_of(:product), resolve: &Bmb.ProductResolver.recommendations/3)
    field(:category, :category, resolve: &Bmb.ProductResolver.category/3)
    field(:updated_at, :string)
    field(:dubina, :string)
    field(:sirina, :string)
    field(:visina, :string)
    field(:promjer, :string)
    field(:description, :string)
  end
end
