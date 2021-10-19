defmodule TodoApp.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias TodoApp.Todos.User

  schema "todos" do
    belongs_to :user, User
    field :description, :string
    field :done, :boolean, default: false
    field :expiration, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:description, :done, :expiration, :user_id])
    |> validate_required([:description, :done, :expiration])
    |> foreign_key_constraint(:user_id)
  end

  @doc false
  def changeset(_todo, :insert, _attrs) do
    # ...
  end

  @doc false
  def changeset(_todo, :update, _attrs) do
    # ...
  end
end
