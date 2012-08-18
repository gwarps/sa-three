require "spec_helper"

describe "movies/show" do
 before(:each) do
  @movie = mock("Movie")
  @movie.stub!(:title).and_return "John Rambo"
  @movie.stub!(:release_date).and_return Date.today
  @movie.stub!(:rating).and_return "PG-13"
  @movie.stub!(:description).and_return nil
  assigns[:movie] = @movie
 end

 it "should display all info about movie" do
  render
  rendered.should contain("Details about #{@movie.title}")
  rendered.should have_link("Edit",href: edit_movie_path(@movie))
 end

 it "should contain link to find movies by director" do
  render
  rendered.should have_link("Find Movies With Same Director",href: movies_by_director_movie_path(@movie))
 end
end
