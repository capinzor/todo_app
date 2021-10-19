defmodule TodoApp.Repo.Migrations.RelationTodoListTodo do
  use Ecto.Migration

  def up do
    alter table(:todos) do
      add(:todo_list_id, references(:todos_lists, on_delete: :delete_all), null: false)
    end
  end

  def down do
    alter table(:todos) do
      remove(:todo_list_id)
    end
  end
end
