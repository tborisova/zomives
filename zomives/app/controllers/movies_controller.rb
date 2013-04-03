class MoviesController < ApplicationController
	def index
		@movies = Movie.all
		
		respond_to do |format|
			format.json  { render :json => @movies.to_json }
  	end
	end
	
	#GET /movies/search?у=2012&mtitle=movie title1&aname=actor_name&dname=director_name
	def search
		user = User.find_by_id(params[:id])
		if user
			if params[:mtitle]
				@movies = Movie.find_name(params[:mtitle]) - Movie.watched_by(user.id).find_name(params[:mtitle])
			elsif params[:aname] && params[:y] && params[:dname]
				@movies = Movie.director(params[:dname]).cast(params[:aname]).year(params[:y]) - Movie.watched_by(user.id).director(params[:dname]).cast(params[:aname]).year(params[:y])
			elsif params[:aname] && params[:y]
				@movies = Movie.cast(params[:aname]).year(params[:y]) - Movie.watched_by(user.id).cast(params[:aname]).year(params[:y])
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
	  else
	  	respond_to do |format|
				format.html  { render :json => "You have watched it" }
	  	end
	  end
	end
	
	#GET /movies/mark_watched?mtitle=movie title1&id=1
	def mark_watched
		user = User.find_by_id(params[:id])
		
		movie = Movie.find_by_name(params[:mtitle])
		
		if !movie.users.include? user
			movie.users << user
			user.movies << movie
			
			respond_to do |format|
				format.html  { render :json => "Done" }
	  	end
		else
			respond_to do |format|
				format.html  { render :json => "Already added" }
	  	end
		end
	end
end
