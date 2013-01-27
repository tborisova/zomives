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
		rows = doc.xpath('//table[@class="results"]/tr/td[@class="image"]/a')
		rows_with_actors = doc.xpath('//table[@class="results"]/tr/td[@class="title"]/span[@class="credit"]')
		row = rows[0]
		
		rows.each_with_index do |row,index|
			name = row.child.attributes["alt"].value
      year = name[/\(.*?\)/].delete("(").delete(")")
    	movie = Movie.new(:name=>name, :year=>year.to_i,:genre=>"action")  		
			
			index_of_with = get_index rows_with_actors, index
		
			next if index_of_with == nil 
			
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
