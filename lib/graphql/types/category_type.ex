defmodule Graphql.Types.Category do
  use Absinthe.Schema.Notation

  object :category do
    field(:name, :string)
    field(:display_name, :string)
    field(:parent_id, :string)
    field(:active, :boolean)
    field(:id, :id)
    field(:childrens, list_of(:category), resolve: &Bmb.CategoryResolver.get_childrens/3)
    field(:image, :string)
  end
end
