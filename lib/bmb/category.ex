defmodule Bmb.Category do
  use Ecto.Schema

  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :display_name, :string
    field :parent_id, :id
    field :active, :boolean, default: true
    field :image, :string

    timestamps()
  end

  def changeset(category, attrs) do
    category
    |> cast(attrs, [
      :name,
      :parent_id,
      :image
    ])
    |> validate_required([:name, :parent_id])
  end
end
