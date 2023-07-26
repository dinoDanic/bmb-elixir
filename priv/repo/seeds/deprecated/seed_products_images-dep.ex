alias Ecto.Repo
alias Bmb.ProductImages
alias Bmb.Repo

File.stream!("#{System.user_home()}/projects/bmb/bmb-elixir/csv/products_images.csv")
|> CSV.decode(headers: true, escape_max_lines: 1000)
|> Enum.each(fn row ->
  {:ok,
   %{
     "image_id" => image_id,
     "product_id" => product_id,
   }} = row

  %ProductImages{
    product_id: String.to_integer(product_id),
    image_id: String.to_integer(image_id),
    is_main: false
  }
  |> Repo.insert!()

end)
