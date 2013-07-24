class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email, index: true
      t.string :token, index: true
      t.belongs_to :grub_session, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
