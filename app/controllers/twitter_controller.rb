class TwitterController < ApplicationController
  before_filter :authenticate_user!
  
  def new
  	twitter_account = TwitterAccount.find_by_user_id(current_user.id)
    if twitter_account.nil?
  	  	twitter_account = TwitterAccount.new
      	twitter_account.user = current_user
      	twitter_account.save
      	redirect_to(twitter_account.authorize_url(twitter_callback_url))
    elsif !twitter_account.active
    	redirect_to(twitter_account.authorize_url(twitter_callback_url))
    else
      	redirect_to(dashboard_path, :notice => 'Already linked to a Twitter Account')
    end 
  end

  def callback
  	if params[:denied] && !params[:denied].empty?
      redirect_to(dashboard_path, :alert => 'Unable to connect with twitter: #{parms[:denied]}')
    else
      twitter_account = TwitterAccount.find_by_oauth_token(params[:oauth_token])
      twitter_account.validate_oauth_token(params[:oauth_verifier], twitter_callback_url)
      twitter_account.save
      notice = twitter_account.active? ? 'Twitter account activated!' : 'Unable to activate twitter account.'
      redirect_to(dashboard_path, :notice => notice)
    end
  end

  def deactivate
  	twitter_account = TwitterAccount.find_by_user_id(current_user.id)
  	twitter_account.update_attributes(:active => false, :oauth_authorize_url => nil)
  	redirect_to(dashboard_path, :notice => 'Twitter account deactivated!')
  end
end
