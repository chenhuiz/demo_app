class FacebookController < ApplicationController
  before_filter :authenticate_user!
  def new
  	facebook_account = FacebookAccount.find_by_user_id(current_user.id)
    if facebook_account.nil?
      facebook_account = FacebookAccount.create()
      facebook_account.user = current_user
      facebook_account.save
      redirect_to(facebook_account.authorize_url(facebook_callback_url(:id => facebook_account.id)))
    elsif !facebook_account.active
      redirect_to(facebook_account.authorize_url(facebook_callback_url(:id => facebook_account.id)))
    else
      redirect_to(dashboard_path, :notice => 'Already linked to a Facebook Account')
    end
  end

  def callback
  	if params[:error_reason] && !params[:error_reason].empty?
      # We have a problem!
      redirect_to(:root, :notice => "Unable to activate facebook: #{params[:error_reason]}")
    elsif params[:code] && !params[:code].empty?
      # This is the callback, we have an id and an access code
      facebook_account = FacebookAccount.find(params[:id]) 
      facebook_account.validate_oauth_token(params[:code], facebook_callback_url(:id => facebook_account.id))
      facebook_account.save
      redirect_to(dashboard_path, :notice => 'Facebook account activated!')
    end
  end

  def deactivate
  	facebook_account = FacebookAccount.find_by_user_id(current_user.id)
  	facebook_account.update_attributes(:active => false, :oauth_authorize_url => nil)
  	redirect_to(dashboard_path, :notice => 'Facebook account deactivated!')
  end

  def post
  	facebook_account = FacebookAccount.find_by_user_id(current_user.id)
  	if !facebook_account.nil? && facebook_account.active
  		facebook_account.post(params[:post])
  		redirect_to(dashboard_path, :notice => "Post to your wall already!")
  	else
  		redirect_to(dashboard_path, :notice => "No facebook account detected!")
  	end
  end
end
