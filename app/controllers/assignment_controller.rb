class AssignmentController < ApplicationController
    get '/:slug/assignments' do
        if logged_in?
            @subject = current_user.subjects.find_by_slug(params[:slug])
            if @subject
                @assignments = @subject.assignments.sort_by { |a| [a[:category], a[:score_possible]] }
                @total_score = @subject.assignments.map(&:score_earned).reduce(:+)
                @total_possible = @subject.assignments.map(&:score_possible).reduce(:+)
                erb :'assignments/index'
            else
                redirect '/subjects'
            end
        else
            redirect '/login'
        end
    end

    post '/assignments' do
        if logged_in?
            if params.values.include?('')
                redirect '/assignments/new'
            else
                @assignment = current_user.assignments.build(params)
                if @assignment.save
                    redirect '/assignments'
                else
                    redirect 'assignments/new'
                end
            end
        else
            redirect '/login'
        end
    end

    get '/:slug/assignments/new' do
        if logged_in?
            @subject = current_user.subjects.find_by_slug(params[:slug])
            if @subject
                @assignments = @subject.assignments.sort_by { |a| [a[:category], a[:score_possible]] }
                @total_score = @subject.assignments.map(&:score_earned).reduce(:+)
                @total_possible = @subject.assignments.map(&:score_possible).reduce(:+)
                erb :'assignments/new'
            else 
                redirect '/subjects'
            end 
        else
            redirect '/login'
        end
    end

    get '/assignments/:id/edit' do
        if logged_in?
            @assignment = Assignment.find_by_id(params[:id])
            if @assignment.user == current_user
                @assignments = current_user.assignments
                @total_score = @total_score = current_user.assignments.map(&:score_earned).reduce(:+)
                @total_possible = current_user.assignments.map(&:score_possible).reduce(:+)
                erb :'assignments/edit'
            end
        else
            redirect '/login'
        end 
    end

    patch '/assignments/:id' do
        if logged_in?
            if params[:assignment].values.include?('')
                redirect "assignments/#{params[:id]}/edit"
            else
                @assignment = Assignment.find_by_id(params[:id])
                if @assignment && @assignment.user == current_user
                    if @assignment.update(params[:assignment])
                        redirect '/assignments'
                    else
                        redirect "/assignments/#{params[:id]}/edit"
                    end
                else
                    redirect '/assignments'
                end
            end
        else
            redirect '/login'
        end
    end

    delete '/assignments/:id' do
        if logged_in?
            @assignment = Assignment.find_by_id(params[:id])
            @assignment.destroy if @assignment && @assignment.user == current_user
            redirect '/assignments'
        else
            redirect '/login'
        end
    end
end