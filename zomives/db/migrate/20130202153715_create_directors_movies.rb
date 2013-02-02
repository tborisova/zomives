class CreateDirectorsMovies < ActiveRecord::Migration
  def up
 		create_table :directors_movies do |t|
 			t.integer :director_id
 			t.integer :movie_id
 		end
  end

  def down
  	drop_table :directors_movies
  end
end
