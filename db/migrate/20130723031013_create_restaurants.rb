class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.string :cross_streets
      t.string :address
      t.string :city
      t.string :state_code
      t.string :postal_code
      t.string :yelp_id
      t.float :yelp_rating
      t.string :yelp_url

      t.timestamps
    end
  end
end
