class MoviesController < ApplicationController
	def get_movies
		@movie = Movie.first
		
		respond_to do |format|
			format.json  { render :json => @movie.to_json }
  	end
	end
end
