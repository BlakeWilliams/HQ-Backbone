class IssuesController < ApplicationController
  before_filter :find_project

  def show
  end

  def create
    @issue = Issue.new(params[:issue])
    if @issue.save
      render 'show'
    else
      render json: @issue.errors.messages.to_json, status: :unprocessable_entity
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
