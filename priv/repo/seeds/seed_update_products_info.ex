alias Ecto.Repo
alias Bmb.Product
alias Bmb.Repo

File.stream!("#{System.user_home()}/projects/bmb/bmb-elixir/csv/products.csv")
|> CSV.decode(headers: true, escape_max_lines: 1000)
|> Enum.each(fn row ->
  {:ok,
   %{
     "product_id" => id,
     "extra_field_22" => sirina_raw,
     "extra_field_23" => dubina_raw,
     "extra_field_24" => visina_raw,
     "extra_field_25" => fallback_promjer,
     "extra_field_44" => fallback1_sirina,
     "extra_field_45" => fallback1_dubina,
     "extra_field_46" => fallback1_visina,
     "extra_field_47" => fallback2_sirina,
     "extra_field_48" => fallback2_dubina,
     "extra_field_49" => fallback2_visina,
     "extra_field_69" => fallback3_sirina,
     "extra_field_70" => fallback3_dubina,
     "extra_field_71" => fallback3_visina,
     "extra_field_6" => fallback4_visina,
     "extra_field_72" => promjer_raw
   }} = row

  sirina = [sirina_raw, fallback1_sirina, fallback2_sirina, fallback3_sirina] |> Enum.find(&(&1 != ""))
  dubina = [dubina_raw, fallback1_dubina, fallback2_dubina, fallback3_dubina] |> Enum.find(&(&1 != ""))
  visina = [visina_raw, fallback1_visina, fallback2_visina, fallback3_visina, fallback4_visina] |> Enum.find(&(&1 != ""))
  promjer = [promjer_raw, fallback_promjer] |> Enum.find(&(&1 != ""))

  case Repo.get(Product, String.to_integer(id)) do
    nil -> IO.puts "Product not found for ID: #{id}"
    product ->
      IO.puts "Found product for ID: #{id}"

      changeset = 
        Product.changeset(product, %{
          sirina: sirina,
          dubina: dubina,
          visina: visina,
          promjer: promjer
        })

      case Repo.update(changeset) do
        {:ok, _product} -> IO.puts "Updated product with ID: #{id}"
        {:error, changeset} -> IO.puts "Failed to update product with ID: #{id}. Errors: #{inspect(changeset.errors)}"
      end
  end
end)
