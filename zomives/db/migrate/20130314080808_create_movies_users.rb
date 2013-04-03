class CreateMoviesUsers < ActiveRecord::Migration
  def up
  	create_table :movies_users do |t|
  		t.integer :movie_id
  		t.integer :user_id
  	end
  end

  def down
  	drop_table :movies_users
  end
end
