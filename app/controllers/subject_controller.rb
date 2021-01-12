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
        if params[:title] == ''
            flash[:notice] = 'Class Creation Failed, Class Needs a Title!'
            redirect '/subjects'
        # Convert the title to downcase to keep consistency
        elsif current_user.subjects.find_by(title: params[:title].downcase)
            flash[:notice] = 'Class Creation Failed, Cannot Have 2 Classes With The Same Name!'
            redirect '/subjects/new'
        else
            @subject = current_user.subjects.build(title: params[:title].downcase)
            if @subject.save
                flash[:notice] = 'Class Successfully Created'
                redirect "/#{@subject.slugify}/assignments"
            end
        end
    end

    delete '/subjects/:slug' do
        @subject = current_user.subjects.find_by_slug(params[:slug])
        # &. is save navigation and is equivelent to destroy if exists
        flash[:notice] = 'Class Successfully Removed!' if @subject&.destroy
        redirect '/subjects'
    end

end
