class FoursquareController < ApplicationController
  before_filter :authenticate_user!, :except => [:push]
  def new
  	foursquare_account = FoursquareAccount.find_by_user_id(current_user.id)
  	if foursquare_account.nil?
  	  	foursquare_account = FoursquareAccount.new
      	foursquare_account.user = current_user
      	foursquare_account.save
      	redirect_to(foursquare_account.authorize_url(foursquare_callback_url))
    elsif !foursquare_account.active
    	redirect_to(foursquare_account.authorize_url(foursquare_callback_url))
    else
      	redirect_to(dashboard_path, :notice => 'Already linked to a Foursquare Account')
    end 
  end

  def callback
  	if !params[:error].nil?
  		redirect_to(dashboard_path,:notice => "Unable to connect to Foursquare: #{params[:error]}")
  	elsif !params[:code].nil?
  		foursquare_account = FoursquareAccount.find_by_user_id(current_user.id)
  		foursquare_account.validate_oauth_token(params[:code], foursquare_callback_url)
  		foursquare_account.save
  		redirect_to(dashboard_path,:notice => "Foursquare account activated!")
  	else
  		redirect_to(dashboard_path,:notice => "Weird error, no code!")
  	end
  end

  def deactivate
  end

  def push
  end
end
