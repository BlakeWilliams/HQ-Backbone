class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find params[:id]
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      render 'show'
    else
      render json: @project.errors.messages.to_json, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes params[:issue]
      render 'show'
    else
      render json: @project.errors.messages.to_json, status: :unprocessable_entity
    end
  end

  def destroy
    Project.find(params[:id]).destroy
  end
end
