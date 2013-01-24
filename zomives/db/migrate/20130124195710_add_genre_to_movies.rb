class AddGenreToMovies < ActiveRecord::Migration
  def up
    add_column :movies, :genre, :string
  end
	
	def down
    remove_column :movies, :genre
  end
end
