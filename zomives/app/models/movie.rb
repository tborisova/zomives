class Movie < ActiveRecord::Base
	has_and_belongs_to_many :actors
	has_and_belongs_to_many :directors
	has_and_belongs_to_many :users
	validates_uniqueness_of :name
		
	attr_accessible :name, :description, :year, :genre	
	
	scope :cast, lambda { |aname| joins(:actors).where(:actors=> {:name=>aname}) }
	scope :year, lambda { |year| where(:year => year) } 
	scope :director, lambda { |dname| joins(:directors).where(:directors=> {:name=>dname}) }
	scope :watched_by, lambda { |user_id| joins(:users).where("movies_users.user_id == ?", user_id) }
	scope :find_name, lambda { |name| where(:name => name) }
end
