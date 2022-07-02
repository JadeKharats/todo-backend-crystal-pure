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
end
