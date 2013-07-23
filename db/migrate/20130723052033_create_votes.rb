class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :restaurant, index: true
      t.references :invite, index: true

      t.timestamps
    end
  end
end
