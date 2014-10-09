class RecommendationsController < ApplicationController
  include RecommendationsHelper

  def index
  	@recommendations = Recommendation.where(user_id: params[:user_id])
  	@user = User.find(params[:user_id])
    respond_to do |format|
      format.html{}
      format.json{render json: @recommendations.to_json(:include => {:visit => {:include => :place}})}
    end
  end

  def new
  	@visit = Visit.find(params[:visit_id])
  	@recommendation = Recommendation.new
  end

  def create
  	@visit = Visit.find(params[:visit_id])
  	@recommendation = @visit.recommendations.create(recommendation_params)
  	@current_user = @visit.user
    @friend = User.find(@recommendation.user_id)
    if @recommendation.valid?
      sendRecommendation(@friend.email, @current_user.username, @visit.place.name, @recommendation.comment)
			redirect_to user_visits_path(current_user)
		else
			render :new
		end
  end

  def destroy
  	recommendation = Recommendation.find(params[:id])
    if recommendation.destroy
        render json: {}
    else
        render status: 400, nothing: true
    end
  end

  def show
  	@recommendation = Recommendation.find(params[:id])
  end

  private

	def recommendation_params
		params.require(:recommendation).permit(:comment, :user_id)
	end
end
