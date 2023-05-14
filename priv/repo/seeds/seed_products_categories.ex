alias Ecto.Repo
alias Bmb.ProductCategory
alias Bmb.Repo

#   1	Roštilji i pečenjare
#   2	Krušne peći
#   3	Uređenje okoliša
#   4	Dekorativne obloge
#   5	Industrijska galanterija
#   6	Ostali proizvodi	
#   7	Mini kamini	
#   8	Roštilji	
#   9	Mini pečenjare
#   10	Pečenjare
#   11	Roštilj oprema		
#   12	Krušne peći hobby	Hobby	
#   13	Profi	
#   14	Oprema
#   15	Žardinjere
#   16	Fontane
#   17	Vrtne figure i statue
#   18	Zdenčeki
#   19	Bunari
#   20	Škarpni elementi
#   21	Stolovi i klupe
#   22	Stalic za suncobrane	
#   23	Ostali betonski elementi
#   24	Paella 22x5
#   25	Paella 29x7
#   26	Cigla 30x15
#   27	Salsa	
#   28	Vita
#   29	Mini vita	
#   30	Topaz
#   31	Cubismo
#   32	Oblutak
#   33	Chimichanga	
#   34	Margarita
#   35	Tacos	
#   36	Podne obloge imitacija drva
#   37	Kape za dimnjak
#   38	Parking elemnti
#   39	Rubanjaci
#   40	Kanalice
#   41	Opločnici
#   42	Uglovni elementi
#   43	Vodomjerna okna
#   44	Septičke jame	
#   45	Izolacija	
#   46	Ljepila
#   47	Šamotne pločice	

products_categories = [
  %{product_id: 1, category_id: 10 },
  %{product_id: 29, category_id: 10 },
]


Repo.transaction(fn ->
  Enum.each(products_categories, fn %{product_id: product_id, category_id: category_id} ->
    product_category = %ProductCategory{product_id: product_id, category_id: category_id}
    Repo.insert!(product_category)
  end)
end)

# File.stream!("#{System.user_home()}/projects/bmb/elixir/csv/products_categories.csv")
# |> CSV.decode(headers: true)
# |> Enum.each(fn row ->
#   {:ok,
#    %{
#      "product_id" => product_id,
#      "category_id" => category_id,
#    }} = row
#
#
#   %ProductCategory{
#     product_id: String.to_integer(product_id),
#     category_id: String.to_integer(category_id),
#   }
#   |> Repo.insert!()
#
# end)
