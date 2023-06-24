alias Ecto.Repo
alias Bmb.Product
alias Bmb.Repo

File.stream!("#{System.user_home()}/projects/bmb/bmb-elixir/csv/products.csv")
|> CSV.decode(headers: true, escape_max_lines: 1000)
|> Enum.each(fn row ->
  {:ok,
   %{
     "name_hr-HR" => name,
     "product_price" => price,
     "product_id" => id,
     "meta_title_hr-HR" => meta_title,
     "meta_description_hr-HR" => meta_description,
     "meta_keyword_hr-HR" => meta_keyword,
     "description_hr-HR" => description,
     "product_ean" => ean,
     "product_weight" => weight,
     "product_publish" => publish_str,
     "extra_field_5" => firebox,
     "extra_field_6" => height,
     "extra_field_7" => work_board
   }} = row

  normalized_name =
    name
    |> String.normalize(:nfd)
    |> String.replace(~r/\p{M}/u, "")
    |> String.replace(~r/[^a-zA-Z0-9\s]/, "")
    |> String.replace(" ", "-")
    |> String.downcase()

  price_float = case String.to_float(price) do
    float when is_float(float) -> float
    _ -> 0.0
  end

  price_string = Float.to_string(price_float)
  price_decimal = Decimal.new(price_string)
  tax_percentage = 25
  tax_decimal = Decimal.new(tax_percentage)
  price_without_tax = Decimal.mult(price_decimal, Decimal.div(100, Decimal.add(100, tax_decimal)))

  %Product{
    name: normalized_name,
    display_name: name,
    price: price_without_tax,
    id: String.to_integer(id),
    meta_title: meta_title,
    meta_description: meta_description,
    meta_keyword: meta_keyword,
    ean: ean,
    weight: weight,
    firebox: firebox,
    height: height,
    work_board: work_board,
    active: publish_str == "1"
  }
  |> Repo.insert!()

end)
