defmodule Bmb.Schema do
  use Absinthe.Schema

  alias Bmb.NewsResolver
  alias Bmb.ProductResolver
  alias Bmb.CategoryResolver

  object :link do
    field :id, non_null(:id)
    field :url, non_null(:string)
    field :description, non_null(:string)
  end

  object :product do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :price, :integer
    field :meta_title, :string
    field :meta_description, :string
    field :meta_keyword, :string
    field :description, :string
    field :ean, :string
    field :weight, :integer
    field :active, :boolean
    # TODO: ENUM CURRENCY
    field :currency, :string
  end

  object :category do
    field :name, non_null(:string)
    field :parent_id, :string
    field :active, :boolean
  end

  query do
    @desc "Get all products"
    field :all_products, list_of(:product) do
      resolve(&ProductResolver.all_products/3)
    end

    @desc "Get Product by ID"
    field :get_product_by_id, :product do
      arg(:id, non_null(:id))
      resolve(&ProductResolver.get_product_by_id/3)
    end

    @desc "Get Products by Category id"
    field :get_products_by_category_id, list_of(:product) do
      arg(:category_id, non_null(:id))
      resolve(&ProductResolver.get_products_by_category_id/3)
    end

    @desc "Get parent Categories"
    field :get_parent_categories, list_of(:category) do
      resolve(&CategoryResolver.get_parent_categories/3)
    end

    @desc "Get categories by parent"
    field :get_categories_by_parent, list_of(:category) do
      resolve(&CategoryResolver.get_categories_by_parent_id/3)
    end
  end

  mutation do
    @desc "Create a new link"
    field :create_link, :link do
      arg(:url, non_null(:string))
      arg(:description, non_null(:string))

      resolve(&NewsResolver.create_link/3)
    end
  end
end
