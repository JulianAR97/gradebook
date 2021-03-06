class AssignmentController < ApplicationController

  before '/:slug/assignments*' do
    @subject = current_user.subjects.find_by_slug(params[:slug])
    if @subject
      @assignments = @subject.assignments.sort_for_table
      @total_score = @subject.assignments.map(&:score_earned).reduce(:+)
      @total_possible = @subject.assignments.map(&:score_possible).reduce(:+)
    else
      redirect '/subjects'
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

  # Create
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

  # Update
  patch '/:slug/assignments/:id' do
    @assignment = Assignment.find_by_id(params[:id])
    if @assignment.update(params[:assignment])
      flash[:notice] = 'Assignment Updated'
      redirect "/#{params[:slug]}/assignments"
    else
      erb :"assignments/edit"
    end
  end

  # Delete
  delete '/:slug/assignments/:id' do
    @assignment = @subject.assignments.find_by_id(params[:id])
    @assignment.destroy if @assignment && @assignment.subject.user == current_user
    flash[:notice] = 'Assignment Deleted'
    redirect "/#{params[:slug]}/assignments"
  end
end

