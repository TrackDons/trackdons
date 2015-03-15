class RenameStartsAtColumn < ActiveRecord::Migration
  def change
    rename_column :recurring_donations, :started_at, :date
  end
end
