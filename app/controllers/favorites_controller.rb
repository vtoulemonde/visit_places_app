class FavoritesController < ApplicationController

	def index
	  	@favorites = Favorite.where(user_id: session[:current_user_id])#.order('order DESC')
		respond_to do |format|
			format.html{}
			format.json { render json: @favorites.to_json(:include =>:place) }
		end
	end

	def create
		puts params
		favorite = Favorite.new favorite_params
		favorite.user_id = session[:current_user_id]
		if favorite.save
	    	render json: {}
	  	else
	    	render status: 400, nothing: true
	  	end
	end

	def destroy
		favorite = Favorite.find(params[:id])
		if favorite.destroy
	    	render json: {}
	  	else
	    	render status: 400, nothing: true
	  	end
	end

	private

	def favorite_params
		params.require(:favorite).permit(:place_id)
	end

end
