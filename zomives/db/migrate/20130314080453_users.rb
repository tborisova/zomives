class Users < ActiveRecord::Migration
  def up
  	create_table :users
  end

  def down
  	drop_table :users
  end
end
