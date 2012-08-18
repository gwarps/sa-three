require "spec_helper"

describe Movie do
 describe "movies_by_director" do
  it "should give correct result" do
    movie = Movie.create!(:title=>"John Rambo",:rating=>"PG-13",:director=>"James Cameron",:release_date=>Date.today-1)
    movie1 = Movie.create!(:title=>"The Titanic",:rating=>"PG-13",:director=>"James Cameron",:release_date=>Date.today-16)
    movie2 = Movie.create!(:title=>"Terminator 2 The Judgement Day",:rating=>"PG-13",:director=>"James Cameron",:release_date=>Date.today-25)
    movie3 = Movie.create!(:title=>"SWAT",:rating=>"PG",:director=>"Client Eastwood",:release_date=>Date.today-34)

    movies = Movie.movies_by_director(movie.id)
    movies.count.should == 2
    movies.should include(movie2)
    movies.should_not include(movie3)
  end
 end
end
