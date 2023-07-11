alias Ecto.Repo
alias Bmb.ProductRecommendations
alias Bmb.Repo

File.stream!("#{System.user_home()}/projects/bmb/bmb-elixir/csv/products_recommendations.csv")
|> CSV.decode(headers: true, escape_max_lines: 1000)
|> Enum.each(fn row ->
  {:ok,
   %{
     "product_id" => product_id,
     "product_related_id" => recommended_product_id,
   }} = row


  %ProductRecommendations{
    product_id: String.to_integer(product_id),
    recommended_product_id: String.to_integer(recommended_product_id),
  }
  |> Repo.insert!()

end)
