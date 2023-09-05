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
    field(:weight, :string)
    field(:firebox, :string)
    field(:work_board, :string)
    field(:description_id, :integer)
    field(:instructions_download_url, :string)
    field(:image_url, :string)
    field(:active, :boolean, default: false)
    field(:dubina, :string)
    field(:sirina, :string)
    field(:visina, :string)
    field(:promjer, :string)
    field(:description, :string)

    has_many(:product_categories, Bmb.ProductCategory)
    has_many(:categories, through: [:product_categories, :category])

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
      :active,
      :dubina,
      :sirina,
      :visina,
      :promjer,
      :firebox,
      :work_board,
      :description
    ])
    |> validate_required([:name, :price])
  end
end
