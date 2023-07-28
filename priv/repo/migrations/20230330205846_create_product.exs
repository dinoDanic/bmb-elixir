defmodule Bmb.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    # execute "CREATE TYPE currencyEnum AS ENUM ('EUR', 'HRK')" example

    create table(:products) do
      add :name, :string, null: false
      add :display_name, :string, null: false
      add :code, :string, unique: true, null: true
      add :price, :decimal, precision: 10, scale: 2, null: false
      add :meta_title, :string, null: true
      add :meta_description, :string, size: 1000, null: true
      add :meta_keyword, :string, size: 1000, null: true
      add :ean, :string, null: true
      add :weight, :string
      add :firebox, :string, null: true
      add :height, :string, null: true
      add :work_board, :string, null: true
      add :image_url, :string, null: true
      add :active, :boolean, null: false

      add :description_id, references(:descriptions)

      timestamps()
    end
  end
end
