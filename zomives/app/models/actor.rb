class Actor < ActiveRecord::Base
	has_and_belongs_to_many :movies
  validates_uniqueness_of :name	
	attr_accessible :name
end
