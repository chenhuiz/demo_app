class FoursquareAccount < ActiveRecord::Base
  attr_accessible :access_token, :foursquare_id, :oauth_authorize_url, :user_id, :active
  belongs_to :user
  has_many :foursquare_checkins

  # local app
  # FOURSQUARE_CLIENT_ID = 'ZSEK1AMUBF1VH1WB0PI32GWUCHIAAVEF2XFJZV5MIVE0C0W4'
  # FOURSQUARE_CLIENT_SECRET = 'UTOXMK0AO2X0TM1XI5DBKOFFUVDEHPRMBZFQJBRVD3FD5WWH'
  # FOURSQUARE_PUSH_SECRET = '2Z2QAG3GD12TMVDW2EX5QH3NJLHU1LJMPGIQFEPLI3WMMQF2'

  # demo-app-chenhui
  FOURSQUARE_CLIENT_ID = 'VAKAY01FKJNQED14OEX5DAYAWFXZBXGVNIUVYOVBVGUCEED5'
  FOURSQUARE_CLIENT_SECRET = 'KE44CREDFEMNL3UR4EJQLFXDLF14GECYUXZVXGB2MIKAANUU'
  FOURSQUARE_PUSH_SECRET = 'V2SX5EVKOGUT5PVXFOXHD4UBVECQ1VHO1RAS0TIW33IIBVM0'

  def authorize_url(callback_url = '')
  	if self.oauth_authorize_url.blank?
      self.oauth_authorize_url = "https://foursquare.com/oauth2/authenticate?client_id=#{FOURSQUARE_CLIENT_ID}&response_type=code&redirect_uri=#{callback_url}"
      self.save!
    end
    self.oauth_authorize_url
  end

  def validate_oauth_token(code, callback_url = '')
  	response = HTTParty.get "https://foursquare.com/oauth2/access_token", :query => {
  		:client_id => FOURSQUARE_CLIENT_ID,
  		:client_secret => FOURSQUARE_CLIENT_SECRET,
  		:grant_type => 'authorization_code',
  		:redirect_uri => callback_url,
  		:code => code
  	}
  	if !response["access_token"].nil?
  		self.access_token = response["access_token"]
  		self.foursquare_id = get_uid(response["access_token"])
  		self.active = true
  	else
  		self.errors.add(:code, "Invalid code, unable to connect to foursquare")
      	self.active = false
  	end
  	self.save
  end

  def get_uid(access_token)
  	response = HTTParty.get "https://api.foursquare.com/v2/users/self", :query => {
  		:oauth_token => access_token
  	}
  	response["response"]["user"]["id"]
  end

end
