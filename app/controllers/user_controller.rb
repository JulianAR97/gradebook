class UserController < ApplicationController
    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect '/subjects'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])

        # Use && user.authenticate(params[:password]) with bcrypt
        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/subjects'
        else
            flash[:notice] = 'Username or Password is Incorrect.'
            erb :'users/login'
        end
    end

    get '/signup' do
        if !logged_in?
            @user = User.new
            erb :'users/signup'
        else
            redirect '/subjects'
        end
    end

    post '/signup' do
        @user = User.new(username: params[:username], password: params[:password])
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect '/subjects'
        else
            erb :'users/signup'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/login'
        else
            redirect '/'
        end
    end
end
