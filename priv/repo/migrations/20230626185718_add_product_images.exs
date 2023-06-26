defmodule Bmb.Repo.Migrations.AddProductImages do
  use Ecto.Migration

  def change do
    create table(:product_images) do
      add :product_id, references(:products, on_delete: :delete_all), null: false
      add :image_id, references(:images, on_delete: :delete_all), null: false
      add :is_main, :boolean, default: false

      timestamps()
    end

    create index(:product_images, [:product_id])
    create index(:product_images, [:image_id])

  end
end
