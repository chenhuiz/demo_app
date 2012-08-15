class FacebookAccount < ActiveRecord::Base
  attr_accessible :access_token, :active, :expire_at, :oauth_authorize_url, :stream_url, :user_id
  belongs_to :user

  # local-app
  # FACEBOOK_CLIENT_ID = '381105935270280'
  # FACEBOOK_CLIENT_SECRET = 'd9b4a63c8c13509fcf0b5d4e699481c1'

  # demo-app-chenhui 
   FACEBOOK_CLIENT_ID = '393338530721521'
   FACEBOOK_CLIENT_SECRET = '76912c695c06d9e63e64e23f737f9bec'

  def authorize_url(callback_url = '')
    if self.oauth_authorize_url.blank?
      self.oauth_authorize_url = "https://graph.facebook.com/oauth/authorize?client_id=#{FACEBOOK_CLIENT_ID}&redirect_uri=#{callback_url}&scope=user_online_presence,publish_stream"
      self.save!
    end
    self.oauth_authorize_url
  end

  def validate_oauth_token(oauth_verifier, callback_url = '')
    response = HTTParty.get 'https://graph.facebook.com/oauth/access_token', :query => {
                   :client_id => FACEBOOK_CLIENT_ID,
                   :redirect_uri => callback_url,
                   :client_secret => FACEBOOK_CLIENT_SECRET,
                   :code => oauth_verifier
                }
    pair = response.body.split("&")[0].split("=")
    expire = response.body.split("&")[1].split("=")
    if (pair[0] == "access_token")
      self.access_token = pair[1]
      response = HTTParty.get 'https://graph.facebook.com/me', :query => { :access_token => self.access_token }
      self.stream_url = JSON.parse(response.body)["link"]
      self.expire_at = Time.at(Time.now + expire[1].to_i)
      self.active = true
    else 
      self.errors.add(:oauth_verifier, "Invalid token, unable to connect to facebook: #{pair[1]}")
      self.active = false
    end
    self.save!
  end

  def post(message)
    @graph = Koala::Facebook::API.new(self.access_token)
    @graph.put_connections("me", "feed", :message => message)
  end
end
