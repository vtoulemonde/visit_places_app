class SessionsController < ApplicationController

    def create
        @user = User.find_by :username => params[:username]

        if @user.nil?
            flash[:error] = "No such user."

        elsif @user.authenticate params[:password]
            session[:current_user_id] = @user.id
            flash[:notice] = "Thank you for logging in, #{@user.username}."

            domain = 'sandboxab13a54924b44d0185046d49a35a2640.mailgun.org'
            api_key = 'key-0664c48b5f3a9476227dc0f6f48c3191'

            username = 'api'
            password = api_key
            url = "https://api.mailgun.net/v2/#{domain}/messages"

            params = {
                :from => "Mailgun Sandbox <postmaster@#{domain}>",
                :to => "#{@users_email}",
                :subject => "New work from Ching Hing Kang",
                :html => "<h3>Hing Kang has just added his latest work onto the site.</h3><br><a href='http://localhost:8080'>Check it out now!</a>"
            }

            options = {
                method: :post,
                params: params,
                userpwd: "#{username}:#{password}"
            }

            trequest = Typhoeus::Request.new(url, options)

            tresponse = trequest.run()

            response.redirect('/')



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
