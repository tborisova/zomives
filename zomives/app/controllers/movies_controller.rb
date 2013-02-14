class MoviesController < ApplicationController
	def index
		@movies = Movie.all
		
		respond_to do |format|
			format.json  { render :json => @movies.to_json }
  	end
	end
end
