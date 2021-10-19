defmodule TodoApp.TodosTest do
  use TodoApp.DataCase

  alias TodoApp.Todos

  describe "todos" do
    alias TodoApp.Todos.Todo

    @valid_attrs %{description: "some description", done: true, expiration: ~N[2010-04-17 14:00:00]}
    @update_attrs %{description: "some updated description", done: false, expiration: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{description: nil, done: nil, expiration: nil}

    def todo_fixture(attrs \\ %{}) do
      {:ok, todo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todos.create_todo()

      todo
    end

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Todos.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Todos.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      assert {:ok, %Todo{} = todo} = Todos.create_todo(@valid_attrs)
      assert todo.description == "some description"
      assert todo.done == true
      assert todo.expiration == ~N[2010-04-17 14:00:00]
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{} = todo} = Todos.update_todo(todo, @update_attrs)
      assert todo.description == "some updated description"
      assert todo.done == false
      assert todo.expiration == ~N[2011-05-18 15:01:01]
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_todo(todo, @invalid_attrs)
      assert todo == Todos.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Todos.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Todos.change_todo(todo)
    end
  end

  describe "users" do
    alias TodoApp.Todos.User

    @valid_attrs %{born_date: ~D[2010-04-17], email: "some email", last_name: "some last_name", name: "some name"}
    @update_attrs %{born_date: ~D[2011-05-18], email: "some updated email", last_name: "some updated last_name", name: "some updated name"}
    @invalid_attrs %{born_date: nil, email: nil, last_name: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todos.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Todos.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Todos.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Todos.create_user(@valid_attrs)
      assert user.born_date == ~D[2010-04-17]
      assert user.email == "some email"
      assert user.last_name == "some last_name"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Todos.update_user(user, @update_attrs)
      assert user.born_date == ~D[2011-05-18]
      assert user.email == "some updated email"
      assert user.last_name == "some updated last_name"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_user(user, @invalid_attrs)
      assert user == Todos.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Todos.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Todos.change_user(user)
    end
  end
end
