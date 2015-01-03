class AddCounterCaches < ActiveRecord::Migration
  def change
    add_column :users, :donations_count, :integer, default: 0
    add_column :projects, :donations_count, :integer, default: 0

    User.all.each { |u| User.reset_counters(u.id, :donations) }
    Project.all.each { |p| Project.reset_counters(p.id, :donations) }
  end
end
