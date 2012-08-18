require "spec_helper"

describe "routing to search director by movies" do
 it "route to /movies/:id/movies_by_director" do
  {:get=>"/movies/3/movies_by_director"}.
  should route_to(
      :controller=>"movies",
      :id=>"3",
      :action=>"movies_by_director"
      )
 end
end
