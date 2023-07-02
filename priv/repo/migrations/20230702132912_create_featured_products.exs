defmodule Bmb.Repo.Migrations.CreateFeaturedProducts do
  use Ecto.Migration

  def change do
     create table(:featured_products) do
      add :product_id, references(:products, on_delete: :nothing)
      timestamps()
    end
    create index(:featured_products, [:product_id])
  end
end
