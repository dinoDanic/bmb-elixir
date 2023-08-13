defmodule Bmb.Repo.Migrations.AddExtraInfoToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :dubina, :string
      add :sirina, :string
      add :visina, :string
      add :promjer, :string
      end
  end
end

