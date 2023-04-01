alias Ecto.Repo
alias Bmb.Category
alias Bmb.Repo

File.stream!("#{System.user_home()}/projects/bmb-elixir/bmb/csv/categories.csv")
|> CSV.decode(headers: true, escape_max_lines: 1000)
|> Enum.each(fn row ->
  {:ok,
   %{
     "category_id" => id,
     "category_parent_id" => parent_id,
     "name_hr-HR" => name,
   }} = row


  %Category{
    name: name,
    id: String.to_integer(id),
    parent_id: String.to_integer(parent_id),
  }
  |> Repo.insert!()

end)
