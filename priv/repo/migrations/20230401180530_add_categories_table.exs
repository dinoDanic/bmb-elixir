defmodule Bmb.Repo.Migrations.AddCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :display_name, :string, null: true
      add :parent_id, :id, null: false
      add :active, :boolean, null: false

      timestamps()
    end
  end
end
