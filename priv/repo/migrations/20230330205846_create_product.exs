defmodule Bmb.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE currencyEnum AS ENUM ('EUR', 'HRK')"

    create table(:products) do
      add :name, :string, null: false
      add :code, :string, unique: true, null: true
      add :price, :decimal, null: false
      add :currency, :currencyEnum, default: "EUR"
      add :meta_title, :string, null: true
      add :meta_description, :string, size: 1000, null: true
      add :meta_keyword, :string, size: 1000, null: true
      add :description, :string, size: 2000, null: true
      add :ean, :string, null: true
      add :weight, :integer, null: true
      add :active, :boolean, null: false

      timestamps()
    end
  end
end
