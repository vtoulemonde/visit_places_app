class UsersController < ApplicationController
    include UsersHelper
    def create
        @user = User.new(user_params)

        if @user.save

            flash[:success] = "Your account has been created! Please login."
            sendEmail(@user.email)
            redirect_to root_path
        else
            render "welcome/index"
        end
    end

    def index
        @users = []
        if params[:search] == ''
            @users = User.all
        elsif !params[:search].nil?
            search = params[:search].downcase
            @users = User.where("lower(username) like ?", "%#{search}%")
        end

        render :index
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params) 
            redirect_to root_path
        else
            render 'edit' 
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :username,
            :email,
            :password,
            :password_confirmation,
            :picture
        )
    end


end
