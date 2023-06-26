defmodule Bmb.Image do
  use Ecto.Schema

  schema "images" do
    field(:url, :string)

    timestamps()
  end
end
