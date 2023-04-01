alias Ecto.Repo
alias Bmb.Product
alias Bmb.Repo

File.stream!("#{System.user_home()}/projects/bmb-elixir/bmb/csv/bmb2.csv")
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
   }} = row


  %Product{
    name: name,
    price: Decimal.new(price),
    id: String.to_integer(id),
    meta_title: meta_title,
    meta_description: meta_description,
    meta_keyword: meta_keyword,
    description: "",
    ean: ean,
    weight:
      Decimal.new(weight |> to_string |> String.replace(",", "."))
      |> Decimal.mult(100)
      |> Decimal.to_integer(),
    active: publish_str == "1",
  }
  |> Repo.insert!()

end)
