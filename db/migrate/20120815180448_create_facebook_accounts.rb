class CreateFacebookAccounts < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.integer :user_id
      t.boolean :active
      t.text :stream_url
      t.text :access_token
      t.text :oauth_authorize_url
      t.datetime :expire_at

      t.timestamps
    end
  end
end
