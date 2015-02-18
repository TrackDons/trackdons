class AddCountriesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :countries, :string, array: true, default: []
  end
end
