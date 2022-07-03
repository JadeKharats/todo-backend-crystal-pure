require "./spec_helper"

describe Todo::TableRoute do
  describe "match_with_a_route?" do
    it "return matching route with right verb and path" do
      route1 = Todo::Route.new("GET", "/right")
      route2 = Todo::Route.new("POST", "/other_right")
      table = Todo::TableRoute.new
      table.list_route.push(route1)
      table.list_route.push(route2)
      matching_route = table.match_with_a_route?("GET", "/right")
      matching_route.size.should eq 1
      matching_route.first.should eq route1
    end
  end
end
