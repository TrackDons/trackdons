class AddAvailableInvitationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :available_invitations, :integer, :default => 5
  end
end
