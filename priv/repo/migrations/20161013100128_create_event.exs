defmodule Classlab.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :public, :boolean, default: false, null: false
      add :slug, :string, null: false
      add :name, :string, null: false
      add :description, :text, null: false
      add :starts_at, :datetime, null: false
      add :ends_at, :datetime, null: false
      add :timezone, :string, null: false

      timestamps()
    end

    create unique_index(:events, [:slug])
  end
end