class MoviesController < ApplicationController
	def index
		@movies = Movie.all
		
		respond_to do |format|
			format.json  { render :json => @movies.to_json }
  	end
	end
	
	#GET /movies/search?у=2012&mtitle=movie title1&aname=actor_name&dname=director_name
	def search
		if params[:mtitle]
			@movies = Movie.find_all_by_name params[:mtitle]
	  elsif params[:aname] && params[:y]
			@movies = Movie.joins(:actors).where(:actors=>{:name=>params[:aname]},:movies=>{:year=>params[:y]})
		elsif params[:dname] && params[:y]
			@movies = Movie.joins(:directors).where(:directors=>{:name=>params[:dname]},:movies=>{:year=>params[:y]})
		elsif params[:dname] && params[:aname]
			@movies = Movie.joins(:directors,:actors).where(:directors=>{:name=>params[:dname]},:actors=>{:name=>params[:aname]})
	  elsif params[:y] #add check for validation
			@movies = Movie.find_all_by_year params[:y]
		elsif params[:aname] 
			@movies = Movie.joins(:actors).where(:actors=>{:name=>params[:aname]})
		elsif params[:dname] 
			@movies = Movie.joins(:directors).where(:directors=>{:name=>params[:dname]})
		end
		
		respond_to do |format|
			format.html  { render :json => @movies.to_json }
  	end
	end
end
