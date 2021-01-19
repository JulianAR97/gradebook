class UserController < ApplicationController
  before '/login' || '/signup' do
    redirect '/subjects' if logged_in?
  end

  get '/login' do
    @user = User.new
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    # Same as if @user and @user.authenticate
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/subjects'
    else
      # Fix this to work with @user.errors ? 
      flash[:notice] = 'Username or Password is Incorrect.'
      erb :'users/login'
    end
  end

  get '/signup' do
    @user = User.new
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])
    # Can I just do @user.save?
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect '/subjects'
    else
      # Render instead of redirect to get error messages
      erb :'users/signup'
    end
  end

  get '/logout' do
    session.destroy if logged_in?
    redirect '/login'
  end
end
