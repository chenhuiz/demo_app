class AddColumnsToTwitterAccount < ActiveRecord::Migration
  def change
  	add_column :twitter_accounts, :user_id, :integer
  	add_column :twitter_accounts, :active, :boolean, :default => false
  	add_column :twitter_accounts, :stream_url, :text
  	add_column :twitter_accounts, :oauth_token, :string
  	add_column :twitter_accounts, :oauth_token_secret, :string
  	add_column :twitter_accounts, :oauth_token_verifier, :string
  	add_column :twitter_accounts, :oauth_authorize_url, :text
  end
end
