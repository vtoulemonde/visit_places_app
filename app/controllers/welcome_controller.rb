class WelcomeController < ApplicationController

	def index
		if logged_in?
			user_logged = current_user
			ids = []
			user_logged.friendships.each do |friendship|
				ids << friendship.friend_id
			end
			@visits = Visit.where(user_id: ids).order('date DESC').limit(20)
		
		end
	end

	def about
	end
	
end
