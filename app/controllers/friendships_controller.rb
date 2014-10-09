class FriendshipsController < ApplicationController
	def create
		@friendship = current_user.friendships.build(:friend_id => params[:friend_id])
		if @friendship.save
			flash[:success] = "Friend have been added"
			redirect_to users_path
		else
		    flash[:danger] = "Unable to add friend."
		    redirect_to users_path
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
