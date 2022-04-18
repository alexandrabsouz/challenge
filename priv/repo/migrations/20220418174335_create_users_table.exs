defmodule Challenge.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :cpf, :string
      add :password_hash, :string
      add :username, :string

      timestamps()
    end

    create unique_index(:users, [:cpf])
  end
end
