class ChangeColumnToFacebookAccounts < ActiveRecord::Migration
  def up
  	change_column :facebook_accounts, :active, :boolean, :default => false
  end

  def down
  end
end
