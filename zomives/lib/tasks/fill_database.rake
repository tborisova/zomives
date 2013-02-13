require 'rails/all'
require 'open-uri'
require 'nokogiri'

namespace :fill_database do
	task :do => :environment do
		create_entries open("http://www.imdb.com/search/title?genres=action&title_type=feature&sort=moviemeter,asc").read
	
		start = 51
		3.times do |time|
			create_entries open("http://www.imdb.com/search/title?genres=action&sort=moviemeter,asc&start=#{start}&title_type=feature")	
			start +=50
		end
	end
	
	def create_entries source
		doc = Nokogiri::HTML(source)
		movie_name_rows = doc.xpath('//table[@class="results"]/tr/td[@class="title"]/a')
		movie_year_rows = doc.xpath('//table[@class="results"]/tr/td[@class="title"]/span[@class="year_type"]')
		rows_with_actors = doc.xpath('//table[@class="results"]/tr/td[@class="title"]/span[@class="credit"]')
		movie_desc = doc.xpath('//table[@class="results"]/tr/td[@class="title"]/span[@class="outline"]')

		movie_name_rows.each_with_index do |row,index|
			name = row.children[0].text
      year = movie_year_rows[index].children[0].text.delete("(").delete(")")
      desc = movie_desc[index].children[0].text if movie_desc[index] 
    	movie = Movie.new(:name=>name, :year=>year.to_i,:genre=>"action",:description=>desc)  		
			
			index_of_with = get_index rows_with_actors, index
		
			next if index_of_with == nil 
			
			1.step(index_of_with,2) do |i|
				dir = Director.find_or_create_by_name(rows_with_actors[index].children[i].children.text)
				movie.directors << dir
			end
			
			index_of_with += 1	
			while (rows_with_actors[index].children[index_of_with] != nil) do
					
					
					movie.actors << Actor.find_or_create_by_name(rows_with_actors[index].children[index_of_with].children.text)
					
					index_of_with += 2
			end
			
			movie.save
		end
		
	end
	
	def get_index rows_with_actors,index 
		if rows_with_actors[index] != nil
			rows_with_actors[index].children.each_with_index do |child,index_of_with|
					if child.text.include?("With:")
						return index_of_with
					end
				end
		else
			puts rows_with_actors[index]
			nil
		end
	end
	
end
