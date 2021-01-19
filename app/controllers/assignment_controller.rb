class AssignmentController < ApplicationController
    before '/:slug/assignments*' do
        @subject = current_user.subjects.find_by_slug(params[:slug])
        if @subject
            @assignments = @subject.assignments.sort_for_table
            @total_score = @subject.assignments.map(&:score_earned).reduce(:+)
            @total_possible = @subject.assignments.map(&:score_possible).reduce(:+)
        else
            redirect '/subjects' unless @subject
        end
    end
    # Index
    get '/:slug/assignments' do
        erb :'assignments/index'
    end

    # New
    get '/:slug/assignments/new' do
        @assignment = Assignment.new
        erb :'assignments/new'
    end

    post '/:slug/assignments' do
        # if empty field
        @assignment = @subject.assignments.build(params[:assignment])
        if @assignment.save
            flash[:notice] = 'Assignment Successfully Created'
            redirect "/#{params[:slug]}/assignments"
        else
            erb :"assignments/new"
        end
    end

    # Edit
    get '/:slug/assignments/:id/edit' do
        @assignment = @subject.assignments.find_by_id(params[:id])
        if @assignment
            @total_score = @assignments.map(&:score_earned).reduce(:+)
            @total_possible = @assignments.map(&:score_possible).reduce(:+)
            erb :'assignments/edit'
        else
            redirect "/#{params[:slug]}/assignments"
        end
    end

    # Edit
    patch '/:slug/assignments/:id' do
        if params[:assignment].values.include?('')
            redirect "/#{params[:slug]}/assignments/#{params[:id]}/edit"
            # Give error message saying that fields cannot be blank
        else
            @assignment = Assignment.find_by_id(params[:id])
            if @assignment
                @assignment.update(params[:assignment])
                flash[:notice] = 'Assignment Updated'
                redirect "/#{params[:slug]}/assignments"
            end
        end
    end

    # Edit
    delete '/:slug/assignments/:id' do
        @assignment = @subject.assignments.find_by_id(params[:id])
        @assignment.destroy if @assignment && @assignment.subject.user == current_user
        flash[:notice] = 'Assignment Deleted'
        redirect "/#{params[:slug]}/assignments"
    end
end

