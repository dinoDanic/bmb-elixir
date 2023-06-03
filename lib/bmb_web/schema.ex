defmodule Bmb.Schema do
  use Absinthe.Schema

  alias Bmb.NewsResolver
  alias Bmb.ProductResolver

  alias Bmb.CategoryResolver

  scalar :decimal do
    serialize(&decimal_to_string/1)
    parse(&string_to_decimal/1)
  end

  defp decimal_to_string(value) do
    Decimal.to_string(value)
  end

  defp string_to_decimal(value) do
    case Decimal.from_string(value) do
      {:ok, decimal} -> {:ok, decimal}
      :error -> {:error, "Invalid decimal"}
    end
  end

  object :link do
    field :id, non_null(:id)
    field :url, non_null(:string)
    field :description, non_null(:string)
  end

  object :product do
    field :id, :id
    field :name, :string
    field :display_name, :string
    field :price, :decimal
    #  Koju picku materinu ovo nece ?
    field :hr_price, :string, resolve: &ProductResolver.hr_price/3
    field :meta_title, :string
    field :meta_description, :string
    field :meta_keyword, :string
    field :description, :string
    field :ean, :string
    field :weight, :integer
    field :active, :boolean
  end

  object :category do
    field :name, non_null(:string)
    field :display_name, non_null(:string)
    field :parent_id, :string
    field :active, :boolean
    field :id, non_null(:id)
    field :childrens, list_of(:category), resolve: &CategoryResolver.get_childrens/3
    # field :total_products_in_category, number, resolver: &CategoryResolver.get_childrens/3
  end

  query do
    @desc "Get Product by ID"
    field :get_product_by_id, :product do
      arg(:id, non_null(:id))
      resolve(&ProductResolver.get_product_by_id/3)
    end

    @desc "Get all products"
    field :all_products, list_of(:product) do
      resolve(&ProductResolver.all_products/3)
    end

    @desc "Get Products by Category id"
    field :get_products_by_category_id, list_of(:product) do
      arg(:category_id, non_null(:id))
      resolve(&ProductResolver.get_products_by_category_id/3)
    end

    @desc "Get categories"
    field :get_categories, list_of(:category) do
      resolve(&CategoryResolver.get_categories/3)
    end

    @desc "Get Category by ID"
    field :get_category_by_id, :category do
      arg(:id, non_null(:id))
      resolve(&CategoryResolver.get_category_by_id/3)
    end

    @desc "Get Complete list of categories"
    field :get_all_categories, list_of(:category) do
      resolve(&CategoryResolver.get_all_categories/3)
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
