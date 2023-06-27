defmodule Bmb.Image do
  use Ecto.Schema

  schema "images" do
    field(:url, :string)
    field(:name, :string)

    timestamps()
  end
end
