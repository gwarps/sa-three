Given /^the following movies exist:$/ do |movies_table|
 movies_table.hashes.each do |movie|
  if movie[:director].eql?("")
   movie[:director]=nil
  end
  Movie.create(movie)
 end
end


Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  movie.director.should==director
end
