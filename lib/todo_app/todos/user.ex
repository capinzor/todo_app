defmodule TodoApp.Todos.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TodoApp.Todos.Todo

  schema "users" do
    has_many :todos, Todo
    field :born_date, :date
    field :email, :string
    field :last_name, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :last_name, :email, :born_date])
    |> validate_required([:name, :last_name, :email, :born_date])
  end
end
