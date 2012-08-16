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
  	foursquare_account = FoursquareAccount.find_by_user_id(current_user.id)
  	foursquare_account.update_attributes(:active => false, :oauth_authorize_url => nil)
  	redirect_to(dashboard_path, :notice => 'Foursquare account deactivated!')
  end

  def push
  	if !params[:secret].nil? && (params[:secret] == FoursquareAccount::FOURSQUARE_PUSH_SECRET)
  		foursquare_account = FoursquareAccount.find_by_foursquare_id(JSON.parse(params[:checkin])["user"]["id"].to_i)
  		if !foursquare_account.nil? && foursquare_account.active
  			FoursquareCheckin.create(:foursquare_account_id => foursquare_account.id, :venue_id => JSON.parse(params[:checkin])["venue"]["id"].to_i, :venue_name => JSON.parse(params[:checkin])["venue"]["name"])
  		end
  	end
  	render :nothing => true
  end
end
