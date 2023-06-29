defmodule Bmb.CategoryImages do
  use Ecto.Schema

  schema "category_images" do
    belongs_to(:category, Bmb.Product)
    belongs_to(:image, Bmb.Image)

    field(:is_main, :boolean)

    timestamps()
  end
end
