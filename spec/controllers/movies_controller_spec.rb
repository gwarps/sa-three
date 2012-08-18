require "spec_helper"

describe MoviesController do
 describe "GET movies_by_director" do
  it "should call the movies_by_director on movie model" do
    fake_results = [mock('Movie'),mock('Movie'),mock('Movie')]
    Movie.stub(:find).and_return(mock('Movie'))
    Movie.stub(:movies_by_director).and_return(fake_results)
    Movie.should_receive(:movies_by_director).with("3")
    get :movies_by_director, {:id=>"3"}
  end

  it "should take results from model and assign to template" do
   fake_results = [mock('Movie'),mock('Movie'),mock('Movie')]
   movie = stub('Movie')
   Movie.stub(:find).and_return(movie)
   Movie.stub(:movies_by_director).and_return(fake_results)
   get :movies_by_director,{:id=>"3"}
   assigns(:movies).should == fake_results
  end
  
  it "should redirect to home page if no record for director found" do
   fake_results = [mock('Movie')]
   movie = mock('Movie')
   movie.stub(:title).and_return("Alien")
   Movie.stub(:find).and_return(movie)
   Movie.stub(:movies_by_director).and_return([])
   get :movies_by_director,{:id=>"3"}
   response.should redirect_to(movies_path)
  end

  it "should redirect with flash message if no record found for director found" do
   fake_results = [mock('Movie')]
   movie = mock('Movie')
   movie.stub(:title).and_return("Alien")
   Movie.stub(:find).and_return(movie)
   Movie.stub(:movies_by_director).and_return([])
   get :movies_by_director,{:id=>"3"}
   flash.now[:notice].should_not be_nil
   flash.now[:notice].should == "'#{movie.title}' has no director info"
  end
 end 
end
