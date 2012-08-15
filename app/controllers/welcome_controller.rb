class WelcomeController < ApplicationController
	before_filter :authenticate_user!, :except => [:index]
	def index
	end

	def dashboard
		twitter_account = TwitterAccount.find_by_user_id(current_user.id)
		@twitter_not_link = twitter_account.nil? || !twitter_account.active
		@twitter_button_class = @twitter_not_link ? "btn-success" : "btn-danger"		
		@twitter_text = @twitter_not_link ? "Link Twitter" : "Unlink Twitter"		
		@twitter_path = @twitter_not_link ? twitter_new_path : twitter_deactivate_path
	end
end
