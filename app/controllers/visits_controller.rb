class VisitsController < ApplicationController
	def index
		@visits = Visit.where(user_id: params[:user_id]).order('date DESC')
		@user = User.find(params[:user_id])
		respond_to do |format|
			format.html{}
			format.json{render json: @visits.to_json(:include =>:place)}
		end
	end

	def new
		@place = Place.find(params[:place_id])
		@visit = Visit.new
	end

	def create
		@place = Place.find(params[:place_id])
		@visit = Visit.new visit_params
		@visit.place_id = @place.id
		@visit.user_id = session[:current_user_id]

		if @visit.save
			flash[:success] = "Your visit has been created."
			if (params[:visit][:picture])
				@photo = Photo.new
				@photo.picture = params[:visit][:picture]
				@photo.visit_id = @visit.id
				@photo.save
			end
			redirect_to user_visits_path(current_user)
		else
			flash[:danger] = "Error: Your visit has not been created."
			render place_path(@place)
		end
	end

	def show
		@visit = Visit.find(params[:id])
		@place = @visit.place
	end

	def edit
		@visit = Visit.find(params[:id])
		@place = @visit.place
	end

	def update
		@visit = Visit.find(params[:id])

		if @visit.update(visit_params)
			if (params[:visit][:picture])
				@photo = Photo.new
				@photo.picture = params[:visit][:picture]
				@photo.visit_id = @visit.id
				@photo.save
			end
			redirect_to user_visits_path(current_user)
		else
			render :edit
		end
	end

	def destroy
		visit = Visit.find(params[:id])
		if visit.destroy
	    	render json: {}
	  	else
	    	render status: 400, nothing: true
	  	end
	end

	private

	def visit_params
		params.require(:visit).permit(:date, :rating, :comment)
	end
end
