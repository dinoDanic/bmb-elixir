defmodule Bmb.Repo.Migrations.RemoveHeigtFromProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      remove :height, :string
      end
  end
end
