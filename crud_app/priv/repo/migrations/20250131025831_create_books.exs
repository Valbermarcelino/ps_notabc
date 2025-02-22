defmodule CrudApp.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :author, :string
      add :year, :integer
      add :isbn, :string

      timestamps(type: :utc_datetime)
    end
  end
end
