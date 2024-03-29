require "./spec_helper"

describe Todo::Handler do
  describe "add item to repo" do
    it "with order Int32" do
      handler = Todo::Handler.new(Todo::Repository.new)
      handler.add_todo_item("Add some handler test", 24.to_i32)
      handler.repo.size.should eq 1
    end

    it "with order Int64" do
      handler = Todo::Handler.new(Todo::Repository.new)
      handler.add_todo_item("Add some handler test", 24.to_i64)
      handler.repo.size.should eq 1
    end

    it "with order Nil" do
      handler = Todo::Handler.new(Todo::Repository.new)
      handler.add_todo_item("Add some handler test", nil)
      handler.repo.size.should eq 1
    end

    it "without order" do
      handler = Todo::Handler.new(Todo::Repository.new)
      handler.add_todo_item("Add some handler test")
      handler.repo.size.should eq 1
    end
  end

  describe "list item" do
    it "return all items" do
      handler = Todo::Handler.new(Todo::Repository.new)
      handler.add_todo_item("Add some handler test")
      handler.add_todo_item("Add more handler test")
      list = handler.list_todos
      list.size.should eq 2
      list.first.title.should eq "Add some handler test"
    end
  end

  describe "clear items" do
    it "remove all items to repo" do
      handler = Todo::Handler.new(Todo::Repository.new)
      handler.add_todo_item("Add some handler test")
      handler.add_todo_item("Add more handler test")
      handler.repo.size.should eq 2
      handler.clear_todos
      handler.repo.size.should eq 0
    end
  end

  describe "remove items" do
    it "remove item from id" do
      handler = Todo::Handler.new(Todo::Repository.new)
      item = handler.add_todo_item("Add some handler test")
      handler.add_todo_item("Add more handler test")
      handler.repo.size.should eq 2
      handler.remove_item(item._id)
      handler.repo.size.should eq 1
      handler.list_todos.first.title.should eq "Add more handler test"
    end
  end

  describe "get todo" do
    it "return item with ID" do
      handler = Todo::Handler.new(Todo::Repository.new)
      item = handler.add_todo_item("Add some handler test")
      handler.add_todo_item("Add more handler test")
      handler.repo.size.should eq 2
      repo_item = handler.get_todo(item._id)
      repo_item.title.should eq "Add some handler test"
    end
  end

  describe "update item to repo" do
    it "with order Int32" do
      handler = Todo::Handler.new(Todo::Repository.new)
      item = handler.add_todo_item("Add some handler test")
      handler.update_item(
        item._id,
        "Update some handler test",
        true,
        item.order.to_i32)
      repo_item = handler.get_todo(item._id)
      repo_item.title.should eq "Update some handler test"
      repo_item.completed.should eq true
    end

    it "with order Int64" do
      handler = Todo::Handler.new(Todo::Repository.new)
      item = handler.add_todo_item("Add some handler test")
      handler.update_item(
        item._id,
        "Update some handler test",
        true,
        item.order.to_i64)
      repo_item = handler.get_todo(item._id)
      repo_item.title.should eq "Update some handler test"
      repo_item.completed.should eq true
    end
  end
end
