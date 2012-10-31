class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find params[:id]
  end

  def create
    @project = Project.new params[:project]
    if @project.save
      render 'show'
    else
      head 422
    end
  end
end
