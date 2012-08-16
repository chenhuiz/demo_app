class ChangeColumnToFoursquareAccounts < ActiveRecord::Migration
  def up
  	add_column :foursquare_accounts, :active, :boolean, :default => false
  end

  def down
  end
end
