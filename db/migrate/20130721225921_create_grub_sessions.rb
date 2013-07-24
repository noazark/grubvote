class CreateGrubSessions < ActiveRecord::Migration
  def change
    create_table :grub_sessions do |t|
      t.string :occasion, index: true
      t.string :token, index: true
      t.belongs_to :decision
      t.belongs_to :inviter
      t.timestamps
    end
  end
end
