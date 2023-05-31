alias Ecto.Repo
alias Bmb.Category
alias Bmb.Repo

categories = [
  # ------------- Parents
  %{name: "rostilji-i-pecenjare", parent_id: 0, display_name: "Roštilji i pečenjare"},
  %{name: "krusne-peci", parent_id: 0, display_name:  "Krušne peći"},
  %{name: "uredenje-okolisa", parent_id: 0, display_name:  "Uređenje okoliša"},
  %{name: "dekorativne-obloge", parent_id: 0, display_name:  "Dekorativne obloge"},
  %{name: "industrijska-galanterija", parent_id: 0, display_name:  "Industrijska galanterija"},
  %{name: "ostali-proizvodi", parent_id: 0, display_name:  "Ostali proizvodi"},
  # ------------- Rostilji i pecenjare
  %{name: "mini-kamini", parent_id: 1, display_name:  "Mini kamini"},
  %{name: "rostilji", parent_id: 1, display_name:  "Roštilji"},
  %{name: "mini-pecenjare", parent_id: 1, display_name:  "Mini pečenjare"},
  %{name: "pecenjare", parent_id: 1, display_name:  "Pečenjare"},
  %{name: "rostilj-oprema", parent_id: 1, display_name:  "Roštilj oprema"},
  # ------------- Krusne peci
  %{name: "krusne-peci-hobby", parent_id: 2, display_name: "Krušne peći hobby"},
  %{name: "profi", display_name: "Profi", parent_id: 2, display_name:  "Profi"},
  %{name: "oprema", display_name: "Oprema", parent_id: 2, display_name:  "Oprema"},
  # ------------- Uredenje okolisa
  %{name: "zardinjere", parent_id: 3, display_name:  "Žardinjere"},
  %{name: "fontane", parent_id: 3, display_name:  "Fontane"},
  %{name: "vrtne-figure-i-statue", parent_id: 3, display_name:  "Vrtne figure i statue"},
  %{name: "zdenceki", parent_id: 3, display_name:  "Zdenčeki"},
  %{name: "bunari", parent_id: 3, display_name:  "Bunari"},
  %{name: "skarpni-elementi", parent_id: 3, display_name:  "Škarpni elementi"},
  %{name: "stolovi-i-klupe", parent_id: 3, display_name:  "Stolovi i klupe"},
  %{name: "stalic-za-suncobrane", parent_id: 3, display_name:  "Stalic za suncobrane"},
  %{name: "ostali-betonski-elementi", parent_id: 3, display_name:  "Ostali betonski elementi"},
  # ------------- Dekorativne obloge
  %{name: "paella-22x5", parent_id: 4, display_name:  "Paella 22x5"},
  %{name: "paella-29x7", parent_id: 4, display_name:  "Paella 29x7"},
  %{name: "cigla-30x15", parent_id: 4, display_name:  "Cigla 30x15"},
  %{name: "salsa", parent_id: 4, display_name:  "Salsa"},
  %{name: "vita", parent_id: 4, display_name:  "Vita"},
  %{name: "mini-vita", parent_id: 4, display_name:  "Mini vita"},
  %{name: "topaz", parent_id: 4, display_name:  "Topaz"},
  %{name: "cubismo", parent_id: 4, display_name:  "Cubismo"},
  %{name: "oblutak", parent_id: 4, display_name:  "Oblutak"},
  %{name: "chimichanga", parent_id: 4, display_name:  "Chimichanga"},
  %{name: "tacos", parent_id: 4, display_name:  "Tacos"},
  %{name: "podne-obloge-imitacija-drva", parent_id: 4, display_name:  "Podne obloge imitacija drva"},
  # ------------- Industrijska galanterija
  %{name: "kape-za-dimnjak", parent_id: 5, display_name:  "Kape za dimnjak"},
  %{name: "parking-elemnti", parent_id: 5, display_name:  "Parking elemnti"},
  %{name: "rubanjaci", parent_id: 5, display_name:  "Rubanjaci"},
  %{name: "kanalice", parent_id: 5, display_name:  "Kanalice"},
  %{name: "oplocnici", parent_id: 5, display_name:  "Opločnici"},
  %{name: "uglovni-elementi", parent_id: 5, display_name:  "Uglovni elementi"},
  %{name: "vodomjerna-okna", parent_id: 5, display_name:  "Vodomjerna okna"},
  %{name: "septičke-jame", parent_id: 5, display_name:  "Septičke jame"},
  # ------------- Ostali proizvodi
  %{name: "izolacija", parent_id: 6, display_name:  "Izolacija"},
  %{name: "ljepila", parent_id: 6, display_name:  "Ljepila"},
  %{name: "samotne-plocice", parent_id: 6, display_name:  "Šamotne pločice"}
  # -------------
]

Repo.transaction(fn ->
  Enum.each(categories, fn %{name: name, parent_id: parent_id, display_name: display_name} ->
    category = %Category{name: name, parent_id: parent_id, display_name: display_name}
    Repo.insert!(category)
  end)
end)

