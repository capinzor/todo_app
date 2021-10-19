defmodule TodoApp.Repo.Migrations.AddUserForTodo do
  use Ecto.Migration

  # def change do
  #   alter table(:todos) do
  #     add(:user_id, references(:users, on_delete: :delete_all))
  #   end
  # end

  def up do
    alter table(:todos) do
      add(:user_id, references(:users, on_delete: :delete_all), null: false)
    end
  end

  def down do
    alter table(:todos) do
      remove(:user_id)
    end
  end
end
