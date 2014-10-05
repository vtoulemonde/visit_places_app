class VisitsController < ApplicationController
	def index
		# TODO search only the visit of the user logged_in
		# TODO how to get the data of the place with the visit
		@visits = Visit.all
	end

	def all
		# TODO search only the visit of the user logged_in
		# TODO how to get the data of the place with the visit
		@visits = Visit.all
		render :index
	end

	def create
		@place = Place.find(params[:place_id])
		@visit = @place.visits.create visit_params

		if @visit.valid?
			flash[:success] = "Your visit has been created."
			redirect_to places_path
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
		redirect_to place_visits_path
	end

	private

	def visit_params
		params.require(:visit).permit(:date, :rating, :comment)
	end
end
