class CreateActorsMovies < ActiveRecord::Migration
  def up
 		create_table :actors_movies do |t|
 			t.integer :actor_id
 			t.integer :movie_id
 		end
  end

  def down
  end
end
