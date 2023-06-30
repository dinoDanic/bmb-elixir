defmodule Bmb.Repo.Migrations.AddIndexToProductsName do
  use Ecto.Migration

  def change do
    create index(:products, [:name])
  end
end
