defmodule Bmb.ProductCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products_categories" do
    belongs_to :product, Bmb.Product
    belongs_to :category, Bmb.Category

    # def changeset(struct, params \\ %{}) do
    #   struct
    #   |> cast(params, [:product_id, :category_id])
    #   |> unique_constraint(:product_id, name: :products_categories_product_id_category_id_index)
    #   |> unique_constraint(:category_id, name: :products_categories_product_id_category_id_index)
    # end

    timestamps()
  end
end
