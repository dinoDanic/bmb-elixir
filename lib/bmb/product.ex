defmodule Bmb.Product do
  use Ecto.Schema

  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :price, :decimal
    field :meta_title, :string
    field :meta_description, :string
    field :meta_keyword, :string
    field :description, :string
    field :ean, :string
    field :weight, :integer
    field :active, :boolean, default: false

    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :name,
      :price,
      :meta_title,
      :meta_description,
      :meta_keyword,
      :description,
      :ean,
      :weight,
      :active
    ])
    |> validate_required([:name, :price, :ean])
  end

end
