class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :twitter
      t.string :donation_url

      t.timestamps
    end
  end
end
