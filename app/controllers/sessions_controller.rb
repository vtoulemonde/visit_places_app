class SessionsController < ApplicationController

    def create
        @user = User.find_by :username => params[:username]

        if @user.nil?
            flash[:error] = "No such user."

        elsif @user.authenticate params[:password]
            session[:current_user_id] = @user.id
            flash[:notice] = "Thank you for logging in, #{@user.username}."

        else
            flash[:error] = "Incorrect password."
        end

        redirect_to root_path
    end

    def destroy
        session[:current_user_id] = nil
        flash[:notice] = "You have been logged out."

        redirect_to root_path
    end

end
