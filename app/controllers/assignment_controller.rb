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

    post '/:slug/assignments' do
        if logged_in?
            @subject = current_user.subjects.find_by_slug(params[:slug])
            if @subject
                # if empty field 
                if params[:assignment].values.include?('')
                    redirect "/#{params[:slug]}/assignments/new"
                else
                    @assignment = @subject.assignments.build(params[:assignment])
                    if @assignment.save
                        redirect "/#{params[:slug]}/assignments"
                    else
                        redirect "/#{params[:slug]}/assignments/new"
                    end
                end
            else
                redirect '/subjects'
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

    get '/:slug/assignments/:id/edit' do
        if logged_in?
            @subject = current_user.subjects.find_by_slug(params[:slug])
            if @subject
                @assignments = @subject.assignments
                @assignment = @assignments.find_by_id(params[:id])
                if @assignment
                    @total_score = @assignments.map(&:score_earned).reduce(:+)
                    @total_possible = @assignments.map(&:score_possible).reduce(:+)
                    erb :'assignments/edit'
                else
                    redirect "/#{params[:slug]}/assignments"
                end
            else
                redirect '/subjects'
            end
        else
            redirect '/login'
        end
    end

    patch '/:slug/assignments/:id' do
        if logged_in?
            @subject = current_user.subjects.find_by_slug(params[:slug])
            if @subject
                if params[:assignment].values.include?('')
                    redirect "/#{params[:slug]}/assignments/#{params[:id]}/edit"
                    # Give error message saying that fields cannot be blank
                else
                    @assignment = Assignment.find_by_id(params[:id])
                    if @assignment
                        if @assignment.update(params[:assignment])
                            redirect "/#{params[:slug]}/assignments"
                            # Give success message
                        else
                            redirect "/assignments/#{params[:id]}/edit"
                        end
                    else
                        redirect '/assignments'
                    end
                end
            else
                redirect '/subjects'
            end
        else
            redirect '/login'
        end
    end

    delete '/:slug/assignments/:id' do
        if logged_in?
            @subject = current_user.subjects.find_by_slug(params[:slug])
            if @subject
                @assignment = @subject.assignments.find_by_id(params[:id])
                @assignment.destroy if @assignment && @assignment.subject.user == current_user
                redirect "/#{params[:slug]}/assignments"
            else
                redirect '/subjects'
            end
        else
            redirect '/login'
        end
    end
end
