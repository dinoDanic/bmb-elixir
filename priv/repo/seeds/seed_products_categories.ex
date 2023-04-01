alias Ecto.Repo
alias Bmb.ProductCategory
alias Bmb.Repo

File.stream!("#{System.user_home()}/projects/bmb-elixir/bmb/csv/products_categories.csv")
|> CSV.decode(headers: true)
|> Enum.each(fn row ->
  {:ok,
   %{
     "product_id" => product_id,
     "category_id" => category_id,
   }} = row


  %ProductCategory{
    product_id: String.to_integer(product_id),
    category_id: String.to_integer(category_id),
  }
  |> Repo.insert!()

end)
