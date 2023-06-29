defmodule Graphql.Types.Category do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  object :category do
    field(:name, :string)
    field(:display_name, :string)
    field(:parent_id, :string)
    field(:active, :boolean)
    field(:id, :id)
    field(:childrens, list_of(:category), resolve: &Bmb.CategoryResolver.get_childrens/3)
    field(:images, list_of(:image), resolve: &Bmb.CategoryResolver.images/3)
  end
end
