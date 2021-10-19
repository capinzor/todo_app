defmodule TodoAppWeb.TodoListControllerTest do
  use TodoAppWeb.ConnCase

  alias TodoApp.Todos

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:todo_list) do
    {:ok, todo_list} = Todos.create_todo_list(@create_attrs)
    todo_list
  end

  describe "index" do
    test "lists all todos_lists", %{conn: conn} do
      conn = get(conn, Routes.todo_list_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Todos lists"
    end
  end

  describe "new todo_list" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.todo_list_path(conn, :new))
      assert html_response(conn, 200) =~ "New Todo list"
    end
  end

  describe "create todo_list" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.todo_list_path(conn, :create), todo_list: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.todo_list_path(conn, :show, id)

      conn = get(conn, Routes.todo_list_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Todo list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.todo_list_path(conn, :create), todo_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Todo list"
    end
  end

  describe "edit todo_list" do
    setup [:create_todo_list]

    test "renders form for editing chosen todo_list", %{conn: conn, todo_list: todo_list} do
      conn = get(conn, Routes.todo_list_path(conn, :edit, todo_list))
      assert html_response(conn, 200) =~ "Edit Todo list"
    end
  end

  describe "update todo_list" do
    setup [:create_todo_list]

    test "redirects when data is valid", %{conn: conn, todo_list: todo_list} do
      conn = put(conn, Routes.todo_list_path(conn, :update, todo_list), todo_list: @update_attrs)
      assert redirected_to(conn) == Routes.todo_list_path(conn, :show, todo_list)

      conn = get(conn, Routes.todo_list_path(conn, :show, todo_list))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, todo_list: todo_list} do
      conn = put(conn, Routes.todo_list_path(conn, :update, todo_list), todo_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Todo list"
    end
  end

  describe "delete todo_list" do
    setup [:create_todo_list]

    test "deletes chosen todo_list", %{conn: conn, todo_list: todo_list} do
      conn = delete(conn, Routes.todo_list_path(conn, :delete, todo_list))
      assert redirected_to(conn) == Routes.todo_list_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.todo_list_path(conn, :show, todo_list))
      end
    end
  end

  defp create_todo_list(_) do
    todo_list = fixture(:todo_list)
    %{todo_list: todo_list}
  end
end
