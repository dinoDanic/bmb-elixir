alias Ecto.Repo
alias Bmb.FeaturedProduct
alias Bmb.Repo

featured_products = [
  %{product_id: 29},
  %{product_id: 67},
  %{product_id: 78},
  %{product_id: 81},
  %{product_id: 469},
  %{product_id: 412},
  %{product_id: 76}
]

Repo.transaction(fn ->
  Enum.each(featured_products, fn %{product_id: product_id} ->
    featured_product = %FeaturedProduct{
      product_id: product_id,
    }

    Repo.insert!(featured_product)
  end)
end)
