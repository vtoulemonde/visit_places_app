class FriendshipsController < ApplicationController
	def create
		@friendship = current_user.friendships.build(:friend_id => params[:friend_id])
		if @friendship.save
			render json: {}
		else
			render status: 400, nothing: true
		end
	end

	def destroy
		@friendship = current_user.friendships.find(params[:id])
		@friendship.destroy
		flash[:success] = "Removed friendship."
		redirect_to friendships_path
	end

	def index

	end

end
