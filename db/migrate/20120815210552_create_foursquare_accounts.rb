class CreateFoursquareAccounts < ActiveRecord::Migration
  def change
    create_table :foursquare_accounts do |t|
      t.integer :user_id
      t.integer :foursquare_id
      t.text :oauth_authorize_url
      t.text :access_token

      t.timestamps
    end
  end
end
