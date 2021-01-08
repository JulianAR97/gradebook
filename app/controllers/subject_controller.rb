class SubjectController < ApplicationController

    get '/subjects' do
        if logged_in?
            @subjects = current_user.subjects
            erb :'subjects/index'
        else
            redirect '/login'
        end
    end

    get '/subjects/new' do
        if logged_in?
            erb :'subjects/new'
        else
            redirect '/login'
        end
    end

    get '/subjects/:slug' do
        if logged_in?
            @subject = current_user.subjects.find_by_slug(params[:slug])
            if @subject
                redirect "/#{@subject.slugify}/assignments"
            else
                redirect '/subjects'
            end
        else
            redirect '/login'
        end
    end

    post '/subjects' do
        if logged_in?
            if params[:title] == ''
                # Display message class creation failed, field cannot be empty
                redirect '/subjects'
            elsif current_user.subjects.find_by(title: params[:title])
                # Display message that cannot create class with same name
                redirect '/subjects/new'
            else
                @subject = current_user.subjects.build(title: params[:title])
                redirect "/subjects/#{@subject.slugify}" if @subject.save
            end
        else
            redirect '/login'
        end
    end

    delete '/subjects/:slug' do
        if logged_in?
            @subject = current_user.subjects.find_by_slug(params[:slug])
            # &. is save navigation and is equivelent to destroy if exists
            @subject&.destroy
            redirect '/subjects'
        else
            redirect '/login'
        end
    end
end
