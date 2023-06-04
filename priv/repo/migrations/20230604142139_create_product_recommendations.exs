defmodule Bmb.Repo.Migrations.CreateProductRecommendations do
  use Ecto.Migration

  def change do
   create table(:product_recommendations) do
      add :product_id, references(:products, on_delete: :delete_all)
      add :recommended_product_id, references(:products, on_delete: :delete_all)

      timestamps()
    end


    create unique_index(:product_recommendations, [:product_id, :recommended_product_id])
  end
end
