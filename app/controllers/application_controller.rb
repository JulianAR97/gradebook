require './config/environment'
require 'rack-flash' # Why is this necessary
class ApplicationController < Sinatra::Base
  use Rack::Flash
  # Check to make sure we are logged in before doing anything
  before ['/subjects*', '/:a/assignments*', '/'] do
    redirect '/login' unless logged_in?
  end

  # This redirects all unknown routes to root route
  not_found do
    status 404
    redirect '/'
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'session secret' # Arbitrary
  end

  # Root route automatically directs to 'homepage' which is subjects.
  # If not logged in, it will redirect to login
  get '/' do
    redirect '/subjects'
  end

  helpers do
    def logged_in?
      # Double bang converts return of current_user to boolean
      !!current_user
    end

    def current_user
      # If current_user value is null, set it, otherwise keep value
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end
