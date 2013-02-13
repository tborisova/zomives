class Movie < ActiveRecord::Base
	has_and_belongs_to_many :actors
	has_and_belongs_to_many :directors
	validates_uniqueness_of :name
		
	attr_accessible :name, :description, :year, :genre	
end
