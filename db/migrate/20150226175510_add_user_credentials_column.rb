class AddUserCredentialsColumn < ActiveRecord::Migration
  def up
    enable_extension :hstore
    add_column :users, :credentials, :hstore
  end

  def down
    disable_extension :hstore
    reove_column :users, :credentials
  end
end
