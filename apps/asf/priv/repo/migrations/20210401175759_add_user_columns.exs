defmodule Asf.Repo.Migrations.AddUserColumns do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :phone_number, :string
      add :avatar_url, :string
    end

    create unique_index(:users, [:username])

    flush()
    Asf.Repo.update_all("users", set: [username: UUID.uuid4()])

    alter table(:users) do
      modify :username, :string, null: false
    end
  end
end
