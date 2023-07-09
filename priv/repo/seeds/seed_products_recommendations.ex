alias Ecto.Repo
alias Bmb.ProductRecommendations
alias Bmb.Repo

product_recomendation = [
  %{product_id: 1, recommended_product_id: 62 },
  %{product_id: 1, recommended_product_id: 47 },
  %{product_id: 1, recommended_product_id: 58 },
]


Repo.transaction(fn ->
  Enum.each(product_recomendation, fn %{product_id: product_id, recommended_product_id: recommended_product_id} ->
    product_recomendations = %ProductRecommendations{product_id: product_id, recommended_product_id: recommended_product_id}
    Repo.insert!(product_recomendations)
  end)
end)
