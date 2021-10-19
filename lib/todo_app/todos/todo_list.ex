defmodule TodoApp.Todos.TodoList do
  use Ecto.Schema
  import Ecto.Changeset
  alias TodoApp.Todos.Todo

  schema "todos_lists" do
    field :name, :string
    field :user_owner_id, :id
    has_many :todos, Todo

    timestamps()
  end

  @doc false
  def changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:name, :user_owner_id])
    |> validate_required([:name])
    |> foreign_key_constraint(:user_owner_id)
  end
end
