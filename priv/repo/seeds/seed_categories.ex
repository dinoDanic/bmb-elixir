alias Ecto.Repo
alias Bmb.Category
alias Bmb.Repo

categories = [
  # ------------- Parents
  %{name: "Roštilji i pečenjare", parent_id: 0, display_name: nil},
  %{name: "Krušne peći", parent_id: 0, display_name: nil},
  %{name: "Uređenje okoliša", parent_id: 0, display_name: nil},
  %{name: "Dekorativne obloge", parent_id: 0, display_name: nil},
  %{name: "Industrijska galanterija", parent_id: 0, display_name: nil},
  %{name: "Ostali proizvodi", parent_id: 0, display_name: nil},
  # ------------- Rostilji i pecenjare
  %{name: "Mini kamini", parent_id: 1, display_name: nil},
  %{name: "Roštilji", parent_id: 1, display_name: nil},
  %{name: "Mini pečenjare", parent_id: 1, display_name: nil},
  %{name: "Pečenjare", parent_id: 1, display_name: nil},
  %{name: "Roštilj oprema", parent_id: 1, display_name: nil},
  # ------------- Krusne peci
  %{name: "Krušne peći hobby", parent_id: 2, display_name: "Hobby"},
  %{name: "Profi", display_name: "Profi", parent_id: 2, display_name: nil},
  %{name: "Oprema", display_name: "Oprema", parent_id: 2, display_name: nil},
  # ------------- Uredenje okolisa
  %{name: "Žardinjere", parent_id: 3, display_name: nil},
  %{name: "Fontane", parent_id: 3, display_name: nil},
  %{name: "Vrtne figure i statue", parent_id: 3, display_name: nil},
  %{name: "Zdenčeki", parent_id: 3, display_name: nil},
  %{name: "Bunari", parent_id: 3, display_name: nil},
  %{name: "Škarpni elementi", parent_id: 3, display_name: nil},
  %{name: "Stolovi i klupe", parent_id: 3, display_name: nil},
  %{name: "Stalic za suncobrane", parent_id: 3, display_name: nil},
  %{name: "Ostali betonski elementi", parent_id: 3, display_name: nil},
  # ------------- Dekorativne obloge
  %{name: "Paella 22x5", parent_id: 4, display_name: nil},
  %{name: "Paella 29x7", parent_id: 4, display_name: nil},
  %{name: "Cigla 30x15", parent_id: 4, display_name: nil},
  %{name: "Salsa", parent_id: 4, display_name: nil},
  %{name: "Vita", parent_id: 4, display_name: nil},
  %{name: "Mini vita", parent_id: 4, display_name: nil},
  %{name: "Topaz", parent_id: 4, display_name: nil},
  %{name: "Cubismo", parent_id: 4, display_name: nil},
  %{name: "Oblutak", parent_id: 4, display_name: nil},
  %{name: "Chimichanga", parent_id: 4, display_name: nil},
  %{name: "Margarita", parent_id: 4, display_name: nil},
  %{name: "Tacos", parent_id: 4, display_name: nil},
  %{name: "Podne obloge imitacija drva", parent_id: 4, display_name: nil},
  # ------------- Industrijska galanterija
  %{name: "Kape za dimnjak", parent_id: 5, display_name: nil},
  %{name: "Parking elemnti", parent_id: 5, display_name: nil},
  %{name: "Rubanjaci", parent_id: 5, display_name: nil},
  %{name: "Kanalice", parent_id: 5, display_name: nil},
  %{name: "Opločnici", parent_id: 5, display_name: nil},
  %{name: "Uglovni elementi", parent_id: 5, display_name: nil},
  %{name: "Vodomjerna okna", parent_id: 5, display_name: nil},
  %{name: "Septičke jame", parent_id: 5, display_name: nil},
  # ------------- Ostali proizvodi
  %{name: "Izolacija", parent_id: 6, display_name: nil},
  %{name: "Ljepila", parent_id: 6, display_name: nil},
  %{name: "Šamotne pločice", parent_id: 6, display_name: nil}
  # -------------
]

Repo.transaction(fn ->
  Enum.each(categories, fn %{name: name, parent_id: parent_id, display_name: display_name} ->
    category = %Category{name: name, parent_id: parent_id, display_name: display_name}
    Repo.insert!(category)
  end)
end)

# SEED HARD CODED CATEGORIES
# File.stream!("#{System.user_home()}/projects/bmb/elixir/csv/hc_categories.csv")
# |> CSV.decode(headers: true, escape_max_lines: 1000)
# |> Enum.each(fn row ->
#   {:ok,
#    %{
#      "name" => name,
#      "parent_id" => parent_id,
#    }} = row
#
#   %Category{
#     name: name,
#     parent_id: String.to_integer(parent_id),
#   }
#   |> Repo.insert!()
#
# end)

# SEED ORGINAL CATEGORIES
# File.stream!("#{System.user_home()}/projects/bmb-elixir/bmb/csv/categories.csv")
# |> CSV.decode(headers: true, escape_max_lines: 1000)
# |> Enum.each(fn row ->
#   {:ok,
#    %{
#      "category_id" => id,
#      "category_parent_id" => parent_id,
#      "name_hr-HR" => name,
#    }} = row
#
#
#   %Category{
#     name: name,
#     id: String.to_integer(id),
#     parent_id: String.to_integer(parent_id),
#   }
#   |> Repo.insert!()
#
# end)
