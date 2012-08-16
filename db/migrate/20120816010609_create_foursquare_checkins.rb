class CreateFoursquareCheckins < ActiveRecord::Migration
  def change
    create_table :foursquare_checkins do |t|
      t.integer :foursquare_account_id
      t.integer :venue_id
      t.string :venue_name

      t.timestamps
    end
  end
end
