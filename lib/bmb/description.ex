defmodule Bmb.Description do
  use Ecto.Schema
  import Ecto.Changeset

  schema "descriptions" do
    field :content, :string

    belongs_to :product, Bmb.Product
    timestamps()
  end

  @doc false
  def changeset(description, attrs) do
    description
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
