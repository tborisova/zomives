class Movie < ActiveRecord::Base
	attr_accessible :name, :description, :year, :genre	
end
