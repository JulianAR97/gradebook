class SubjectController < ApplicationController

    get '/subjects' do
        @subjects = current_user.subjects
        erb :'subjects/index'
    end

    get '/subjects/new' do
        erb :'subjects/new'
    end

    get '/subjects/:slug' do
        @subject = current_user.subjects.find_by_slug(params[:slug])
        if @subject
            redirect "/#{@subject.slugify}/assignments"
        else
            redirect '/subjects'
        end
    end

    post '/subjects' do
        # Convert the title to downcase to keep consistency
        if params[:title].downcase! == ''
            # Display message class creation failed, field cannot be empty
            redirect '/subjects'
        elsif current_user.subjects.find_by(title: params[:title])
            # Display message that cannot create class with same name
            redirect '/subjects/new'
        else
            @subject = current_user.subjects.build(title: params[:title])
            redirect "/subjects/#{@subject.slugify}" if @subject.save
        end
    end

    delete '/subjects/:slug' do
        @subject = current_user.subjects.find_by_slug(params[:slug])
        # &. is save navigation and is equivelent to destroy if exists
        @subject&.destroy
        redirect '/subjects'
    end
end
