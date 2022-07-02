require "json"
# TODO: Write documentation for `Todo`
module Todo
  VERSION = "0.1.0"


  class Item
    include JSON::Serializable
    property _id : String
    property title : String
    property order : Int32
    property completed : Bool
  end

  class Repository
    def initialize
      @todo_list = Hash(String,Item).new
    end

    def save(item : Item)
      @todo_list[item._id] = item
      item
    end

    def get_todo(id : String)
      @todo_list[id]
    end

    def size
      @todo_list.size
    end

    def get_all
      list = Array(Item).new
      @todo_list.each do |_id, item|
        list.push(item)
      end
      list
    end

    def delete(item_id : String)
      @todo_list.delete item_id
    end

    def clear
      @todo_list.clear
    end

  end
end
