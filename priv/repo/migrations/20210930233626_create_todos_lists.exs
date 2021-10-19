defmodule TodoApp.Repo.Migrations.CreateTodosLists do
  use Ecto.Migration

  def change do
    create table(:todos_lists) do
      add :name, :string
      add :user_owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:todos_lists, [:user_owner_id])
  end
end
