defmodule Bmb.Repo.Migrations.AddCategoryImages do
  use Ecto.Migration

  def change do
    create table(:category_images) do
      add :category_id, references(:categories, on_delete: :delete_all), null: false
      add :image_id, references(:images, on_delete: :delete_all), null: false
      add :is_main, :boolean, default: false

      timestamps()
    end

    create index(:category_images, [:category_id])
    create index(:category_images, [:image_id])

  end
end
