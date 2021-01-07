class SubjectController < ApplicationController
    get '/subjects' do
        if logged_in?
            @subjects = current_user.subjects
            erb :'subjects/index'
        end
    end
end