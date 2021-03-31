defmodule Asf.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :title, :string
      add :sub_title, :string
      add :content, :text

      timestamps()
    end
  end
end
