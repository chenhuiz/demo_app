class ChangeColumnTo4sqAnd4sqCheckin < ActiveRecord::Migration
  def up
  	change_column :foursquare_accounts, :foursquare_id, :string
  	change_column :foursquare_checkins, :venue_id, :text
  end

  def down
  end
end
