module UsersHelper
	def sendEmail(email)
		    domain = 'sandboxab13a54924b44d0185046d49a35a2640.mailgun.org'
            api_key = 'key-0664c48b5f3a9476227dc0f6f48c3191'

            username = 'api'
            password = api_key
            url = "https://api.mailgun.net/v2/#{domain}/messages"

            params = {
                :from => "Mailgun Sandbox <postmaster@#{domain}>",
                :to => "#{email}",
                :subject => "Welcome to Dream Places",
                :html => "<h2>You have just signed up to happiness.</h2><br><a href='http://localhost:3000'>Check it out now!</a>"
            }

            options = {
                method: :post,
                params: params,
                userpwd: "#{username}:#{password}"
            }

            request = Typhoeus::Request.new(url, options)

            response = request.run()
	end
end
