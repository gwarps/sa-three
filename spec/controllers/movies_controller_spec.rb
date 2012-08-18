require "spec_helper"

describe MoviesController do
 describe "GET movies_by_director" do
  it "should call the movies_by_director on movie model" do
    Movie.should_receive(:movies_by_director).with("3")
    get :movies_by_director, {:id=>"3"}
  end

  it "should take results from model and assign to template" do
   fake_results = [mock('Movie'),mock('Movie'),mock('Movie')]
   Movie.stub(:movies_by_director).and_return(fake_results)
   get :movies_by_director,{:id=>"3"}
   assigns(:movies).should == fake_results
  end
 end 
end
