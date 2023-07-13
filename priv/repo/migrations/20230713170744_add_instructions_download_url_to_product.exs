defmodule Bmb.Repo.Migrations.AddInstructionsDownloadUrlToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :instructions_download_url, :string, size: 1000
      end
  end
end
