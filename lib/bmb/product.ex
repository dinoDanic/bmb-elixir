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
    field(:height, :string)
    field(:work_board, :string)
    field(:description_id, :integer)
    field(:active, :boolean, default: false)

    has_many(:product_categories, Bmb.ProductCategory)
    has_many(:categories, through: [:product_categories, :category])

    has_many(:product_images, Bmb.ProductImages)
    has_many(:images, through: [:product_images, :image])

    @indexes [{:name, :asc}]

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
