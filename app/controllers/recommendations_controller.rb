class RecommendationsController < ApplicationController
  def index
  	@recommendations = Recommendation.where(user_id: params[:user_id])
  	@user = User.find(params[:user_id])
  end

  def new
  	@visit = Visit.find(params[:visit_id])
  	@recommendation = Recommendation.new
  end

  def create
  	@visit = Visit.find(params[:visit_id])
  	@recommendation = @visit.recommendations.create recommendation_params
  	if @recommendation.valid?
			redirect_to user_visits_path(current_user)
		else
			render :new
		end
  end

  def destroy
  	recommendation = Recommendation.find(params[:id])
  	recommendation.destroy
  	redirect_to user_recommendations_path(current_user)
  end

  def show
  	@recommendation = Recommendation.find(params[:id])
  end

  private

	def recommendation_params
		params.require(:recommendation).permit(:comment, :user_id)
	end
end
