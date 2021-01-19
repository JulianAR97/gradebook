class SubjectController < ApplicationController

  get '/subjects' do
    @subjects = current_user.subjects
    erb :'subjects/index'
  end

  get '/subjects/new' do
    @subject = Subject.new
    erb :'subjects/new'
  end

  # If the subject exists, we will automatically redirect to the assignments
  # Path for it
  get '/subjects/:slug' do
    @subject = current_user.subjects.find_by_slug(params[:slug])
    if @subject
      redirect "/#{@subject.slugify}/assignments"
    else
      redirect '/subjects'
    end
  end

  post '/subjects' do
    @subject = current_user.subjects.build(title: params[:title])
    if @subject.valid?
      @subject.save
      redirect "/#{@subject.slugify}/assignments"
    else
      erb :'subjects/new'
    end
  end

  delete '/subjects/:slug' do
    @subject = current_user.subjects.find_by_slug(params[:slug])
    # &. is save navigation and is equivelent to destroy if exists
    flash[:notice] = 'Class Successfully Removed!' if @subject&.destroy
    redirect '/subjects'
  end
end
