class IssuesController < ApplicationController

  def index
    @issues = Issue.where('status = ?', 'open')
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def create
    find_project
    @issue = Issue.new(params[:issue])
    if @issue.save
      render 'show'
    else
      render json: @issue.errors.messages.to_json, status: :unprocessable_entity
    end
  end

  def update
    @issue = Issue.find(params[:id])
    params[:issue][:due] = Date.today if params[:issue][:due] == "Today"
    if @issue.update_attributes params[:issue]
      render 'show'
    else
      render json: @issue.errors.messages.to_json, status: :unprocessable_entity
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
