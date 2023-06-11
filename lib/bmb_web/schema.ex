defmodule BmbWeb.Schema do
  use Absinthe.Schema
  use BmbWeb.Auth.CustomMiddleware
  alias Graphql.Queries.{CurrentUser}

  alias Bmb.ProductResolver
  alias Graphql.Mutations.CreateSession

  alias Bmb.CategoryResolver

  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
  end

  object :link do
    field(:id, non_null(:id))
    field(:url, non_null(:string))
    field(:description, non_null(:string))
  end

  object :product do
    field(:id, :id)
    field(:name, :string)
    field(:display_name, :string)
    field(:price, :string)
    field(:price_neto, :string, resolve: &ProductResolver.price_neto/3)
    field(:hrk_price, :string, resolve: &ProductResolver.hrk_price/3)
    field(:hrk_price_neto, :string, resolve: &ProductResolver.hrk_price_neto/3)
    field(:meta_title, :string)
    field(:meta_description, :string)
    field(:meta_keyword, :string)
    field(:ean, :string)
    field(:weight, :integer)
    field(:firebox, :string)
    field(:height, :string)
    field(:work_board, :string)
    field(:active, :boolean)
    field(:recommendations, list_of(:product), resolve: &ProductResolver.recommendations/3)
    field(:description, :description, resolve: &ProductResolver.description/3)
  end

  object :category do
    field(:name, non_null(:string))
    field(:display_name, non_null(:string))
    field(:parent_id, :string)
    field(:active, :boolean)
    field(:id, non_null(:id))
    field(:childrens, list_of(:category), resolve: &CategoryResolver.get_childrens/3)
    # field :total_products_in_category, number, resolver: &CategoryResolver.get_childrens/3
  end

  object :description do
    field(:id, :id)
    field(:content, :string)
  end

  object :session do
    # field(:account, :account)
    field(:token, :string)
  end

  object :account do
    field(:id, :id)
    field(:email, :string)
    field(:username, :string)
    field(:first_name, :string)
    field(:last_name, :string)
  end

  input_object :edit_product_input do
    field(:name, :string)
    field(:display_name, :string)
    field(:active, :boolean)
  end

  input_object :create_session_input do
    field(:email, :string)
    field(:username, :string)
    field(:password, non_null(:string))
  end

  query do
    field :me, :account do
      resolve(&CurrentUser.call/3)
    end

    @desc "Get Product by ID"
    field :get_product_by_id, :product do
      arg(:id, non_null(:id))
      resolve(&ProductResolver.get_product_by_id/3)
    end

    @desc "Get all active products"
    field :all_active_products, list_of(:product) do
      resolve(&ProductResolver.all_active_products/3)
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
    field :edit_product, :product do
      arg(:id, non_null(:id))
      arg(:input, :edit_product_input)
      resolve(&ProductResolver.edit_product/3)
    end

    field :create_session, :session do
      arg(:input, :create_session_input)
      resolve(&CreateSession.resolve/3)
    end
  end
end
