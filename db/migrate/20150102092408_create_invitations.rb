class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :invitation_token
      t.string :invited_email
      t.boolean :used, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
