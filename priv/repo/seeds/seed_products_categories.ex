alias Ecto.Repo
alias Bmb.Category
alias Bmb.ProductCategory
alias Bmb.Repo

File.stream!("#{System.user_home()}/projects/bmb/bmb-elixir/csv/products_categories.csv")
|> CSV.decode(headers: true, escape_max_lines: 1000)
|> Enum.each(fn row ->
  {:ok,
   %{
     "category_id" => category_id,
     "product_id" => product_id,
   }} = row

  case Bmb.Repo.get(Bmb.Category, String.to_integer(category_id)) do
    %Bmb.Category{} ->
      %ProductCategory{
        category_id: String.to_integer(category_id),
        product_id: String.to_integer(product_id)
      }
      |> Repo.insert!()

    nil ->
      IO.puts("Skipped insertion for ProductCategory with non-existing category_id: #{category_id}")
  end
end)
