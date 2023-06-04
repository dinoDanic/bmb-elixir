defmodule Bmb.Product do
  use Ecto.Schema

  import Ecto.Changeset

  schema "products" do
    field(:name, :string)
    field(:display_name, :string)
    field(:price, :decimal)
    field(:meta_title, :string)
    field(:meta_description, :string)
    field(:meta_keyword, :string)
    field(:ean, :string)
    field(:weight, :integer)
    field(:firebox, :string)
    field(:height, :string)
    field(:work_board, :string)
    field(:active, :boolean, default: false)

    has_one :descriptions, Bmb.Description

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
      :ean,
      :weight,
      :active
    ])
    |> validate_required([:name, :price, :ean])
  end
end
