class UserController < ApplicationController
    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect '/assignments'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])

        # Use && user.authenticate(params[:password]) with bcrypt
        if @user && @user.password == params[:password]
            session[:user_id] = @user.id
            redirect '/assignments'
        else
            redirect '/signup'
        end
    end

    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else
            redirect '/assignments'
        end
    end

    post '/signup' do
        if params.values.include?('') || !!User.find_by(username: params[:username])
            # flash message saying that fields can't be empty or username already exists
            redirect '/signup'
        elsif !valid_password?(params[:password])
            redirect '/signup'
        else
            @user = User.create(username: params[:username], password: params[:password])
            session[:user_id] = @user.id
            redirect '/assignments'
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