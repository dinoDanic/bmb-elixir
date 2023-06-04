defmodule Bmb.Repo.Migrations.CreateDescriptions do
  use Ecto.Migration

  def change do
    create table(:descriptions) do
      add :content, :string
      timestamps()
    end

  end
end
