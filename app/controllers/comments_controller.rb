class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment posted!"
      if @comment.commentable_type == "Update"
        redirect_to issue_update_path(@comment.commentable.issue, @comment.commentable)
      else
        redirect_to @comment.commentable
      end
    else
      flash[:danger] = "Something went wrong!"
      redirect_to @comment.commentable
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_type, :commentable_id)
    end
  
end
