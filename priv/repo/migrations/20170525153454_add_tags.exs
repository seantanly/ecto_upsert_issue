defmodule EctoUpsertIssue.Repo.Migrations.AddTags do
  use Ecto.Migration

  def change do
    create table(:tags, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      timestamps()
    end
    create index(:tags, [:name], unique: true)
  end
end
