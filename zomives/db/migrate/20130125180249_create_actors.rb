class CreateActors < ActiveRecord::Migration
  def up
		create_table :actors do |a|
			a.string :name
		end
  end

  def down
  	drop_table :actors
  end
end
