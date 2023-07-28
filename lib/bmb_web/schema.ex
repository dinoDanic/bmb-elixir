defmodule BmbWeb.Schema do
  use Absinthe.Schema
  alias Bmb.FeaturedProductResolver
  use BmbWeb.Auth.CustomMiddleware
  use Absinthe.Relay.Schema, :modern

  alias Graphql.Queries.{CurrentUser}
  alias Bmb.ProductResolver
  alias Graphql.Mutations.CreateSession
  alias Bmb.CategoryResolver

  import_types(Absinthe.Plug.Types)
  import_types(Graphql.Types.Product)
  import_types(Graphql.Types.Category)

  connection(node_type: :product)

  node interface do
    resolve_type(fn
      %Bmb.Product{}, _ ->
        :product

      _, _ ->
        nil
    end)
  end

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

  object :description do
    field(:id, :id)
    field(:content, :string)
  end

  object :session do
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
    field(:price, :string)
    field(:weight, :string)
    field(:height, :string)
    field(:firebox, :string)
    field(:work_board, :string)
    field(:ean, :string)
    field(:image_url, :string)
  end

  input_object :create_session_input do
    field(:email, :string)
    field(:username, :string)
    field(:password, non_null(:string))
  end

  query do
    node field do
      resolve(fn
        %{type: :product, id: local_id}, _ ->
          {:ok, Bmb.Repo.get(Bmb.Product, local_id)}

        _, _ ->
          {:error, "Unknown node"}
      end)
    end

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
    connection field(:all_products, node_type: :product) do
      arg(:category_ids, list_of(:string))
      arg(:name, :string)
      arg(:active, :boolean)
      resolve(&ProductResolver.all_products/3)
    end

    @desc "Get Products by Category id"
    field :get_products_by_category_id, list_of(:product) do
      arg(:category_id, non_null(:id))
      resolve(&ProductResolver.get_products_by_category_id/3)
    end

    @desc "Get Products by Category name"
    field :get_products_by_category_name, list_of(:product) do
      arg(:category_name, non_null(:string))
      resolve(&ProductResolver.get_products_by_category_name/3)
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

    @desc "Get Category by name"
    field :get_category_by_name, :category do
      arg(:name, non_null(:string))
      resolve(&CategoryResolver.get_category_by_name/3)
    end

    @desc "Get Complete list of categories"
    field :get_all_categories, list_of(:category) do
      resolve(&CategoryResolver.get_all_categories/3)
    end

    @desc "Get featured products"
    field :featured_products, list_of(:product) do
      resolve(&FeaturedProductResolver.get_featured_products/3)
    end

    @desc "Get recommendatiosn"
    field :recommendations, list_of(:product) do
      resolve(&ProductResolver.get_recommendations/3)
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

    field :add_image_to_category, :category do
      arg(:category_id, non_null(:id))
      arg(:image_url, non_null(:string))
      resolve(&CategoryResolver.add_image_to_category/3)
    end

    field :add_recommendation, :product do
      arg(:product_id, non_null(:id))
      arg(:recommended_product_id, non_null(:id))
      resolve(&ProductResolver.add_recommendation/3)
    end

    field :remove_recommendation, :boolean do
      arg(:product_id, non_null(:id))
      arg(:recommended_product_id, non_null(:id))
      resolve(&ProductResolver.remove_recommendation/3)
    end
  end
end
