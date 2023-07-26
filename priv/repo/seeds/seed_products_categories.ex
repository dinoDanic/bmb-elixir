alias Ecto.Repo
alias Bmb.Category
alias Bmb.ProductCategory
alias Bmb.Repo
import Ecto.Query

File.stream!("#{System.user_home()}/projects/bmb/bmb-elixir/csv/products_categories.csv")
|> CSV.decode(headers: true, escape_max_lines: 1000)
|> Enum.each(fn row ->
  {:ok,
   %{
     "category_id" => category_id,
     "product_id" => product_id,
   }} = row

  category =
    from(c in Bmb.Category, where: c.category_id == ^category_id)
    |> Bmb.Repo.one()

  product =
    from(p in Bmb.Product, where: p.id == ^product_id)
    |> Bmb.Repo.one()

  case {category, product} do
    {nil, _} ->
      IO.puts("Skipped insertion for ProductCategory with non-existing category_id: #{category_id}, and product_id: #{product_id}")

    {_, nil} ->
      IO.puts("Skipped insertion for ProductCategory with existing category_id: #{category_id}, but non-existing product_id: #{product_id}")

    {category_struct, product_struct} ->
      %ProductCategory{
        category_id: category_struct.id,
        product_id: product_struct.id
      }
      |> Bmb.Repo.insert!()
  end
end)
