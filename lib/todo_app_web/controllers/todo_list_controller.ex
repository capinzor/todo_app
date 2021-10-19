defmodule TodoAppWeb.TodoListController do
  use TodoAppWeb, :controller

  alias TodoApp.Todos
  alias TodoApp.Todos.TodoList

  def index(conn, _params) do
    todos_lists = Todos.list_todos_lists()
    render(conn, "index.html", todos_lists: todos_lists)
  end

  def new(conn, _params) do
    user = conn.assigns.current_user
    changeset = Todos.change_todo_list(%TodoList{}, %{"user_owner_id" => user.id})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo_list" => todo_list_params}) do
    case Todos.create_todo_list(todo_list_params) |> IO.inspect() do
      {:ok, todo_list} ->
        conn
        |> put_flash(:info, "Todo list created successfully.")
        |> redirect(to: Routes.todo_list_path(conn, :show, todo_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo_list = Todos.get_todo_list_with_todos!(id)
    render(conn, "show.html", todo_list: todo_list)
  end

  def edit(conn, %{"id" => id}) do
    todo_list = Todos.get_todo_list!(id)
    changeset = Todos.change_todo_list(todo_list)
    render(conn, "edit.html", todo_list: todo_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo_list" => todo_list_params}) do
    todo_list = Todos.get_todo_list!(id)

    case Todos.update_todo_list(todo_list, todo_list_params) do
      {:ok, todo_list} ->
        conn
        |> put_flash(:info, "Todo list updated successfully.")
        |> redirect(to: Routes.todo_list_path(conn, :show, todo_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo_list: todo_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_list = Todos.get_todo_list!(id)
    {:ok, _todo_list} = Todos.delete_todo_list(todo_list)

    conn
    |> put_flash(:info, "Todo list deleted successfully.")
    |> redirect(to: Routes.todo_list_path(conn, :index))
  end
end
