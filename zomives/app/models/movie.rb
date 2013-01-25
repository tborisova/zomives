class Movie < ActiveRecord::Base
	has_and_belongs_to_many :actors
	
	attr_accessible :name, :description, :year, :genre	
end
