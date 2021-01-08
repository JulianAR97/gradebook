require './config/environment'

class ApplicationController < Sinatra::Base

        
    before '/*' do
        redirect '/login' unless logged_in?
    end

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, 'session secret' # Simplified
        # use Rack::Flash
    end

    get '/' do
        redirect '/subjects'
    end

    helpers do
        def logged_in?
            # Double bang converts return of current_user to boolean
            !!current_user
        end

        def current_user
            @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
        end

        def valid_password?(password)
            criteria = [
                password.size >= 8, # password is 8 or more chars
                !!password.match(/\d/), # password includes number
                !!password.match(/[!@#$%^&*()+~`{}'":;.,<>?]/) #password includes special char
            ]
            # if each of the criteria is true, method returns true
            !criteria.include?(false)
        end
    end

end