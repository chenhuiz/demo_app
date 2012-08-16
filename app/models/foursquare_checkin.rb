class FoursquareCheckin < ActiveRecord::Base
  attr_accessible :foursquare_account_id, :venue_id, :venue_name
  belongs_to :foursquare_account
end
