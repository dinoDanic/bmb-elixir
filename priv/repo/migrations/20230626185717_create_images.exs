defmodule Bmb.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
     create table(:images) do
      add :url, :string, null: false, unique: true
      add :name, :string, null: false, unique: true

      timestamps()
    end
  end
end
