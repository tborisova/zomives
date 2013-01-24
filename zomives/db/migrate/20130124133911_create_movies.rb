class CreateMovies < ActiveRecord::Migration
  def up
  	create_table :movies do |m|
  		m.string :name
     	m.text :description
      m.integer :year
      m.timestamps
  	end
  end

  def down
  	drop_table :movies
  end
end
