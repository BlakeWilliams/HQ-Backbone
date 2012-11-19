class CommentsController < ApplicationController
  before_filter :find_issue

  def create
    @comment = @issue.comments.build(params[:comment])
    if @comment.save
      render json: {id: @comment.id}
    else
      render json: @issue.errors.messages.to_json, status: :unprocessable_entity
    end
  end

  private
  def find_issue
    @issue = Issue.find(params[:issue_id])
  end
end
