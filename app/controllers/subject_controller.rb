class SubjectController < ApplicationController
    get '/subjects' do
        if logged_in?
            @subjects = current_user.subjects
            erb :'subjects/index'
        end
    end

    get '/subjects/:slug' do
        if logged_in? 
            @subject = current_user.subjects.find_by_slug(params[:slug])
            if @subject
                erb :'subjects/'
            end
        end
    end


end