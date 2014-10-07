class VisitsController < ApplicationController
	def index
		@visits = Visit.where(user_id: params[:user_id]).order('date DESC')
		@user = User.find(params[:user_id])
		respond_to do |format|
			format.html{}
			format.json{render json: @visits.to_json(:include =>[:place])}
		end
	end

	def all
		@visits = Visit.all
		render :index
	end

	def create
		@place = Place.find(params[:place_id])
		@visit = Visit.new visit_params
		@visit.place_id = @place.id
		@visit.user_id = session[:current_user_id]

		if @visit.save
			flash[:success] = "Your visit has been created."
			redirect_to user_visits_path(current_user)
		else
			flash[:error] = "Error: Your visit has not been created."
			render place_path(@place)
		end
	end

	def edit
		@visit = Visit.find(params[:id])
		@place = @visit.place
	end

	def update
		@visit = Visit.find(params[:id])
		if @visit.update visit_params
			redirect_to place_visits_path
		else
			render :edit
		end
	end

	def destroy
		@visit = Visit.find(params[:id])
		@visit.destroy
		flash[:success] = "Your visit has been deleted."
		redirect_to user_visits_path(current_user)
	end

	private

	def visit_params
		params.require(:visit).permit(:date, :rating, :comment)
	end
end
