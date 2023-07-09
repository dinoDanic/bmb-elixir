# DEPRECATED

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
  %{product_id: 32, category_id: 10 },
  %{product_id: 33, category_id: 10 },
  %{product_id: 34, category_id: 10 },
  %{product_id: 37, category_id: 10 },
  %{product_id: 48, category_id: 10 },
  %{product_id: 49, category_id: 10 },
  %{product_id: 50, category_id: 10 },
  %{product_id: 59, category_id: 10 },
  %{product_id: 60, category_id: 10 },
  %{product_id: 61, category_id: 10 },
  %{product_id: 62, category_id: 10 },
  %{product_id: 63, category_id: 10 },
  %{product_id: 64, category_id: 10 },
  %{product_id: 66, category_id: 10 },
  %{product_id: 67, category_id: 10 },
  %{product_id: 71, category_id: 10 },
  %{product_id: 73, category_id: 10 },
  %{product_id: 74, category_id: 10 },
  %{product_id: 75, category_id: 10 },
  %{product_id: 76, category_id: 10 },
  %{product_id: 78, category_id: 10 },
  %{product_id: 81, category_id: 10 },
  %{product_id: 83, category_id: 11 },
  %{product_id: 84, category_id: 11 },
  %{product_id: 85, category_id: 11 },
  %{product_id: 86, category_id: 11 },
  %{product_id: 87, category_id: 11 },
  %{product_id: 91, category_id: 15 },
  %{product_id: 92, category_id: 15 },
  %{product_id: 93, category_id: 15 },
  %{product_id: 95, category_id: 15 },
  %{product_id: 96, category_id: 15 },
  %{product_id: 97, category_id: 15 },
  %{product_id: 99, category_id: 15 },
  %{product_id: 100, category_id: 15 },
  %{product_id: 101, category_id: 15 },
  %{product_id: 102, category_id: 15 },
  %{product_id: 103, category_id: 15 },
  %{product_id: 104, category_id: 15 },
  %{product_id: 105, category_id: 15 },
  %{product_id: 106, category_id: 15 },
  %{product_id: 107, category_id: 15 },
  %{product_id: 109, category_id: 15 },
  %{product_id: 110, category_id: 15 },
  %{product_id: 112, category_id: 15 },
  %{product_id: 113, category_id: 15 },
  %{product_id: 114, category_id: 15 },
  %{product_id: 115, category_id: 15 },
  %{product_id: 116, category_id: 15 },
  %{product_id: 117, category_id: 15 },
  %{product_id: 130, category_id: 15 },
  %{product_id: 132, category_id: 15 },
  %{product_id: 133, category_id: 15 },
  %{product_id: 134, category_id: 15 },
  %{product_id: 135, category_id: 15 },
  %{product_id: 136, category_id: 15 },
  %{product_id: 137, category_id: 15 },
  %{product_id: 138, category_id: 15 },
  %{product_id: 139, category_id: 15 },
  %{product_id: 140, category_id: 15 },
  %{product_id: 141, category_id: 15 },
  %{product_id: 142, category_id: 15 },
  %{product_id: 143, category_id: 15 },
  %{product_id: 144, category_id: 15 },
  %{product_id: 147, category_id: 4 },
  %{product_id: 148, category_id: 4 },
  %{product_id: 150, category_id: 4 },
  %{product_id: 152, category_id: 4 },
  %{product_id: 153, category_id: 4 },
  %{product_id: 154, category_id: 4 },
  %{product_id: 155, category_id: 4 },
  %{product_id: 156, category_id: 4 },
  %{product_id: 157, category_id: 4 },
  %{product_id: 158, category_id: 4 },
  %{product_id: 159, category_id: 4 },
  %{product_id: 160, category_id: 4 },
  %{product_id: 161, category_id: 4 },
  %{product_id: 162, category_id: 4 },
  %{product_id: 164, category_id: 4 },
  %{product_id: 165, category_id: 4 },
  %{product_id: 166, category_id: 4 },
  %{product_id: 167, category_id: 4 },
  %{product_id: 168, category_id: 4 },
  %{product_id: 174, category_id: 8 },
  %{product_id: 176, category_id: 16 },
  %{product_id: 177, category_id: 16 },
  %{product_id: 178, category_id: 16 },
  %{product_id: 182, category_id: 16 },
  %{product_id: 184, category_id: 16 },
  %{product_id: 185, category_id: 16 },
  %{product_id: 186, category_id: 16 },
  %{product_id: 193, category_id: 16 },
  %{product_id: 194, category_id: 16 },
  %{product_id: 195, category_id: 16 },
  %{product_id: 197, category_id: 16 },
  %{product_id: 197, category_id: 17 },
  %{product_id: 199, category_id: 17 },
  %{product_id: 200, category_id: 17 },
  %{product_id: 201, category_id: 17 },
  %{product_id: 202, category_id: 17 },
  %{product_id: 204, category_id: 17 },
  %{product_id: 205, category_id: 17 },
  %{product_id: 207, category_id: 17 },
  %{product_id: 208, category_id: 17 },
  %{product_id: 210, category_id: 17 },
  %{product_id: 211, category_id: 17 },
  %{product_id: 212, category_id: 17 },
  %{product_id: 213, category_id: 17 },
  %{product_id: 215, category_id: 17 },
  %{product_id: 217, category_id: 17 },
  %{product_id: 218, category_id: 17 },
  %{product_id: 219, category_id: 17 },
  %{product_id: 220, category_id: 17 },
  %{product_id: 221, category_id: 20 },
  %{product_id: 222, category_id: 21 },
  %{product_id: 223, category_id: 21 },
  %{product_id: 224, category_id: 21 },
  %{product_id: 225, category_id: 21 },
  %{product_id: 226, category_id: 21 },
  %{product_id: 227, category_id: 21 },
  %{product_id: 228, category_id: 21 },
  %{product_id: 229, category_id: 18 },
  %{product_id: 230, category_id: 18 },
  %{product_id: 231, category_id: 18 },
  %{product_id: 232, category_id: 18 },
  %{product_id: 233, category_id: 18 },
  %{product_id: 234, category_id: 18 },
  %{product_id: 235, category_id: 18 },
  %{product_id: 236, category_id: 18 },
  %{product_id: 237, category_id: 18 },
  %{product_id: 238, category_id: 18 },
  %{product_id: 240, category_id: 18 },
  %{product_id: 241, category_id: 18 },
  %{product_id: 246, category_id: 18 },
  %{product_id: 247, category_id: 18 },
  %{product_id: 248, category_id: 18 },
  %{product_id: 249, category_id: 18 },
  %{product_id: 250, category_id: 18 },
  %{product_id: 257, category_id: 17 },
  %{product_id: 264, category_id: 17 },
  %{product_id: 265, category_id: 17 },
  %{product_id: 271, category_id: 17 },
  %{product_id: 272, category_id: 17 },
  %{product_id: 273, category_id: 17 },
  %{product_id: 274, category_id: 17 },
  %{product_id: 275, category_id: 17 },
  %{product_id: 276, category_id: 17 },
  %{product_id: 278, category_id: 17 },
  %{product_id: 279, category_id: 17 },
  %{product_id: 281, category_id: 17 },
  %{product_id: 282, category_id: 17 },
  %{product_id: 283, category_id: 17 },
  %{product_id: 284, category_id: 17 },
  %{product_id: 286, category_id: 17 },
  %{product_id: 287, category_id: 17 },
  %{product_id: 290, category_id: 17 },
  %{product_id: 291, category_id: 17 },
  %{product_id: 293, category_id: 17 },
  %{product_id: 294, category_id: 17 },
  %{product_id: 296, category_id: 17 },
  %{product_id: 297, category_id: 17 },
  %{product_id: 298, category_id: 17 },
  %{product_id: 299, category_id: 17 },
  %{product_id: 301, category_id: 17 },
  %{product_id: 302, category_id: 17 },
  %{product_id: 303, category_id: 17 },
  %{product_id: 305, category_id: 17 },
  %{product_id: 306, category_id: 17 },
  %{product_id: 307, category_id: 17 },
  %{product_id: 309, category_id: 17 },
  %{product_id: 310, category_id: 17 },
  %{product_id: 311, category_id: 10 },
  %{product_id: 313, category_id: 39 },
  %{product_id: 314, category_id: 39 },
  %{product_id: 315, category_id: 39 },
  %{product_id: 316, category_id: 39 },
  %{product_id: 317, category_id: 39 },
  %{product_id: 318, category_id: 39 },
  %{product_id: 319, category_id: 39 },
  %{product_id: 320, category_id: 39 },
  %{product_id: 321, category_id: 40 },
  %{product_id: 325, category_id: 42 },
  %{product_id: 326, category_id: 42 },
  %{product_id: 327, category_id: 42 },
  %{product_id: 328, category_id: 43 },
  %{product_id: 329, category_id: 43 },
  %{product_id: 330, category_id: 43 },
  %{product_id: 331, category_id: 37 },
  %{product_id: 332, category_id: 37 },
  %{product_id: 333, category_id: 37 },
  %{product_id: 334, category_id: 37 },
  %{product_id: 335, category_id: 37 },
  %{product_id: 338, category_id: 38 },
  %{product_id: 339, category_id: 38 },
  %{product_id: 340, category_id: 38 },
  %{product_id: 341, category_id: 38 },
  %{product_id: 342, category_id: 38 },
  %{product_id: 343, category_id: 22 },
  %{product_id: 344, category_id: 22 },
  %{product_id: 345, category_id: 22 },
  %{product_id: 346, category_id: 22 },
  %{product_id: 347, category_id: 22 },
  %{product_id: 348, category_id: 22 }
  %{product_id: 349, category_id: 22 }
]


Repo.transaction(fn ->
  Enum.each(products_categories, fn %{product_id: product_id, category_id: category_id} ->
    product_category = %ProductCategory{product_id: product_id, category_id: category_id}
    Repo.insert!(product_category)
  end)
end)
