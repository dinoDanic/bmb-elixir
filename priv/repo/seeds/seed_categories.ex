alias Ecto.Repo
alias Bmb.Category
alias Bmb.Repo

skip_category_ids = ["33", "34", "56", "78", "80", "81", "89"]

File.stream!("#{System.user_home()}/projects/bmb/bmb-elixir/csv/categories.csv")
|> CSV.decode(headers: true, escape_max_lines: 1000)
|> Enum.each(fn row ->
  {:ok,
   %{
     "category_id" => category_id,
     "category_parent_id" => parent_id,
     "name_hr-HR" => display_name,
     "alias_hr-HR" => name,
     "category_publish" => category_publish,
   }} = row

  custom_name =
    case category_id do
      "1" -> "rostilji-i-pecenjare"
      "84" -> "krusne-peci"
      "86" -> "ostalo"
      "55" -> "ostali-betonski-elementi"
      "11" -> "krusne-peci-profi"
      _ -> name
    end

  if category_publish == "0" or category_id in skip_category_ids do
    IO.puts("Skipped insertion for category with name: #{name} and ID: #{category_id}")
  else
    %Category{
      name: custom_name,
      display_name: display_name,
      category_id: String.to_integer(category_id),
      parent_id: String.to_integer(parent_id),
      active: category_publish == "1",
      image: nil
    }
    |> Repo.insert!()
  end
end)
