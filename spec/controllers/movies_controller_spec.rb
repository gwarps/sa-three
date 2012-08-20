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

 describe "Show Action" do
  it "should assign movie to controller instance variable" do
   movie = mock('Movie')
   movie.stub(:id).and_return("3")
   Movie.stub(:find).and_return(movie)
   get :show,{:id=>3}
   assigns(:movie).should==movie
  end
 end

 describe "Create Action" do
  it "it should create a new Movie" do
   expect{
     post :create, movie: {:title=>"Ghost Protocol",:director=>"Tom Hanks",:release_date=>Date.today-100,:rating=>"PG"}
   }.to change(Movie,:count).by(1)
  end

  it "should assign @movie variable and display flash message" do
   movie = mock('Movie')
   movie.stub(:title).and_return("Ghost Protocol")
   Movie.stub(:create!).and_return(movie)
   post :create, movie: {:title=>"Ghost Protocol",:director=>"Tom Hanks",:release_date=>Date.today-100,:rating=>"PG"}
   assigns(:movie).should==movie
   flash.now[:notice].should == "#{movie.title} was successfully created."
   response.should redirect_to(movies_path)
  end
 end

 describe "Update Action" do
  it "should assign and update" do
   movie = mock('Movie')
   movie.stub(:id).and_return("3")
   movie.stub(:title).and_return("Ghost Protocol")
   movie.stub(:update_attributes!).and_return(:true)
   Movie.stub(:find).and_return(movie)
   post :update, {:id=>3}
   assigns(:movie).should==movie
   flash.now[:notice].should == "#{movie.title} was successfully updated."
   response.should redirect_to(movie_path(movie))
  end
 end

 describe "Destroy Action" do
  it "should call destroy and display with flash message followed by redirection" do
   movie = mock('Movie')
   movie.stub(:id).and_return("3")
   movie.stub(:title).and_return("Ghost Protocol")
   movie.stub(:destroy).and_return(:true)
   Movie.stub(:find).and_return(movie)
   
   post :destroy, {:id=>3}
   assigns(:movie).should==movie
   flash.now[:notice].should == "Movie '#{movie.title}' deleted."
   response.should redirect_to(movies_path)
  end
 end

 describe "Index Action" do
  it "should assign session for ratings" do
   session[:ratings]=nil
   get :index,:ratings=>{"NC-17"=>"1", "R"=>"1"}
   assigns(:selected_ratings).should=={"NC-17"=>"1", "R"=>"1"}
   session[:ratings].should=={"NC-17"=>"1", "R"=>"1"}
   session[:sort].should be_nil
  end

  it "should assign session for sort values" do
   session[:sort] = nil
   get :index,:sort=>"title"
   assigns(:title_header).should == "hilite"
   session[:sort].should == "title"
   session[:ratings].should be_nil
  end
 end
end
