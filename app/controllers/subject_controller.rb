class SubjectController < ApplicationController
    get '/subjects' do
        if logged_in?
            @subjects = current_user.subjects
            erb :'subjects/index'
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


end