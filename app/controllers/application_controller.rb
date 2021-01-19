require './config/environment'
require 'rack-flash' # Why is this necessary
class ApplicationController < Sinatra::Base
  use Rack::Flash
  before '/subjects*' && '/:a/assignments*' && '/' do
    redirect '/login' unless logged_in?
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'session secret' # Simplified
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
  end
end
