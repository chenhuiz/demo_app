class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource_or_scope)
  	if resource_or_scope.is_a? (User)
  		if facebook_token_expire (resource_or_scope)
  			facebook_account = FacebookAccount.find_by_user_id(resource_or_scope.id)
        	facebook_account.authorize_url(facebook_callback_url(:id => facebook_account.id))
  		else
  			dashboard_path
  		end
  	else
  		super
  	end
  end

  def facebook_token_expire(user)
    facebook_account = FacebookAccount.find_by_user_id(user.id)
    !facebook_account.nil? ? (Time.now > facebook_account.expire_at) : false
  end
end
