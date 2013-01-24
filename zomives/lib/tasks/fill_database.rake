require 'rails/all'
require 'open-uri'
require 'nokogiri'

namespace :fill_database do
	task :do => :environment do
		create_entries open("http://www.imdb.com/search/title?genres=action&title_type=feature&sort=moviemeter,asc").read
								#	http://www.imdb.com/search/title?genres=action&sort=moviemeter,asc&start=51&title_type=feature
								#	http://www.imdb.com/search/title?genres=action&sort=moviemeter,asc&start=101&title_type=feature

		start = 51
		5.times do |time|
			create_entries open("http://www.imdb.com/search/title?genres=action&sort=moviemeter,asc&start=#{start}&title_type=feature")	
			start +=50
		end
	end
	
	def create_entries source
		doc = Nokogiri::HTML(source)
		rows = doc.xpath('//table[@class="results"]/tr/td[@class="image"]/a')
		
		rows.each do |row|
			name = row.child.attributes["alt"].value
      year = name[/\(.*?\)/].delete("(").delete(")")
    	movie = Movie.new(:name=>name, :year=>year.to_i,:genre=>"action")  		
			movie.save
		end
		
	end
end
