class AddInvitedUserToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :invited_user_id, :integer
  end
end
