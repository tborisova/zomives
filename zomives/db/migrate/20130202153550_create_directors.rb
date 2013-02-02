class CreateDirectors < ActiveRecord::Migration
  def up
 		create_table :directors do |t|
 			t.string :name
 		end
  end

  def down
  	drop_table :directors
  end
end
