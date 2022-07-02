require "./spec_helper"

describe Todo do
  describe Todo::Repository do
    it "save item" do
      repo = Todo::Repository.new
      json = "{\"_id\":\"gfsjgsf\",\"title\":\"Do some test\",\"order\":3,\"completed\":false}"
      item = Todo::Item.from_json json
      repo.save(item)
      result = repo.get_todo(item._id)
      result.to_json.should eq json
    end

    it "return all item" do
      repo = Todo::Repository.new
      json = "{\"_id\":\"gfsjgsf\",\"title\":\"Do some test\",\"order\":3,\"completed\":false}"
      item = Todo::Item.from_json json
      repo.save(item)
      json2 = "{\"_id\":\"gfsj\",\"title\":\"Do more test\",\"order\":2,\"completed\":false}"
      item2 = Todo::Item.from_json json2
      repo.save(item2)
      repo.size.should eq 2
      repo_expected = "[#{json},#{json2}]"
      repo.get_all.to_json.should eq repo_expected
    end

    it "delete one item" do
      repo = Todo::Repository.new
      json = "{\"_id\":\"gfsjgsf\",\"title\":\"Do some test\",\"order\":3,\"completed\":false}"
      item = Todo::Item.from_json json
      repo.save(item)
      json2 = "{\"_id\":\"gfsj\",\"title\":\"Do more test\",\"order\":2,\"completed\":false}"
      item2 = Todo::Item.from_json json2
      repo.save(item2)
      repo.size.should eq 2
      repo.delete("gfsjgsf")
      repo.size.should eq 1
      repo_expected = "[#{json2}]"
      repo.get_all.to_json.should eq repo_expected
    end

    it "clear all entries" do
      repo = Todo::Repository.new
      json = "{\"_id\":\"gfsjgsf\",\"title\":\"Do some test\",\"order\":3,\"completed\":false}"
      item = Todo::Item.from_json json
      repo.save(item)
      json2 = "{\"_id\":\"gfsj\",\"title\":\"Do more test\",\"order\":2,\"completed\":false}"
      item2 = Todo::Item.from_json json2
      repo.save(item2)
      repo.size.should eq 2
      repo.clear
      repo.size.should eq 0
      repo_expected = "[]"
      repo.get_all.to_json.should eq repo_expected
    end
  end
end
