require "json"
require "uuid"

# TODO: Write documentation for `Todo`
module Todo
  VERSION = "0.1.0"

  class Item
    include JSON::Serializable
    property _id : String
    property title : String
    property order : Int32
    property completed : Bool

    def initialize(@_id, @title, @order, @completed)
    end
  end

  class Route
    def initialize(@verb : String, @path : String)
    end

    def match_with_verb_and_path(context_verb : String, context_path : String)
      (match_verb?(context_verb) && match_path?(context_path))
    end

    def match_verb?(context_verb)
      @verb == context_verb
    end

    def match_path?(context_path)
      if @path.includes? ":"
        match_path_regex?(context_path)
      else
        @path == context_path
      end
    end

    def match_path_regex?(context_path)
      regex_path = @path.split("/").map { |element| element.starts_with?(":") ? "(.)+" : element }.join("/")
      Regex.new(regex_path).match(context_path).is_a? Regex::MatchData
    end
  end

  class TableRoute
    property list_route : Array(Route)

    def initialize
      @list_route = Array(Route).new
    end

    def match_with_a_route?(context_verb : String, context_path : String)
      @list_route.select! { |route| route.match_with_verb_and_path(context_verb, context_path) }
    end
  end

  class Repository
    def initialize
      @todo_list = Hash(String, Item).new
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

  class Handler
    property repo : Repository

    def initialize(@repo)
    end

    def add_todo_item(title : String, order : Int32)
      item = Item.new(
        UUID.random.to_s,
        title,
        order,
        false
      )
      @repo.save(item)
    end

    def add_todo_item(title : String, order : Int64)
      add_todo_item title, order.to_i32
    end

    def add_todo_item(title : String, order : Nil)
      add_todo_item title, (@repo.size + 1)
    end

    def add_todo_item(title : String)
      add_todo_item title, nil
    end

    def list_todos
      @repo.get_all
    end

    def clear_todos
      @repo.clear
    end

    def remove_item(item_id : String)
      @repo.delete(item_id)
    end

    def get_todo(item_id : String)
      @repo.get_todo(item_id)
    end

    def update_item(item_id : String, title : String, completed : Bool, order : Int32)
      item = @repo.get_todo(item_id)
      item.title = title
      item.completed = completed
      item.order = order
      @repo.save item
    end

    def update_item(item_id : String, title : String, completed : Bool, order : Int64)
      update_item(item_id, title, completed, order.to_i32)
    end
  end
end
