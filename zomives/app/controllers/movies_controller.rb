class MoviesController < ApplicationController
	def index
		@movies = Movie.all
		
		respond_to do |format|
			format.json  { render :json => @movies.to_json }
  	end
	end
	
	#GET /movies/search?у=2012&mtitle=movie title1&aname=actor_name&dname=director_name
	def search
		if params[:mtitle] #VALIDATION
			@movies = Movie.find_all_by_name params[:mtitle]
	  elsif params[:aname] && params[:y] && params[:dname]
	  	@movies = Movie.director(params[:dname]).cast(params[:aname]).year(params[:y])
	  elsif params[:aname] && params[:y]
			@movies = Movie.cast(params[:aname]).year(params[:y])
		elsif params[:dname] && params[:y]
			@movies = Movie.director(params[:dname]).year(params[:y])
		elsif params[:dname] && params[:aname]
			@movies = Movie.director(params[:dname]).cast(params[:aname])
	  elsif params[:y]
			@movies = Movie.year params[:y]
		elsif params[:aname] 
			@movies = Movie.cast params[:aname]
		elsif params[:dname] 
			@movies = Movie.director params[:dname]
		end
		
		respond_to do |format|
			format.html  { render :json => @movies.to_json }
  	end
	end
end
