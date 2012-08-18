class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.movies_by_director(id)
   movie = Movie.find(id)
   return Movie.where("director=? and id<>?",movie.director,movie.id)
  end
end
