require "./spec_helper"

describe Todo::Route do
  describe "match" do
    it "with right path and verb" do
      path = "/right"
      verb = "GET"
      route = Todo::Route.new("GET", "/right")
      route.match_with_verb_and_path(verb, path).should eq true
    end

    it "not with right path and wrong verb" do
      path = "/right"
      verb = "POST"
      route = Todo::Route.new("GET", "/right")
      route.match_with_verb_and_path(verb, path).should eq false
    end

    it "not with wrong path and right verb" do
      path = "/wrong"
      verb = "GET"
      route = Todo::Route.new("GET", "/right")
      route.match_with_verb_and_path(verb, path).should eq false
    end

    it "not with wrong path and verb" do
      path = "/wrong"
      verb = "POST"
      route = Todo::Route.new("GET", "/right")
      route.match_with_verb_and_path(verb, path).should eq false
    end

    it "with params into path" do
      path = "/right/aadgf-gege-geqge-gfeg"
      verb = "GET"
      route = Todo::Route.new("GET", "/right/:id")
      route.match_with_verb_and_path(verb, path).should eq true
    end
  end
end
