defmodule Bmb.ProductImages do
  use Ecto.Schema

  schema "product_images" do
    belongs_to(:product, Bmb.Product)
    belongs_to(:image, Bmb.Image)

    field(:is_main, :boolean)

    timestamps()
  end
end
