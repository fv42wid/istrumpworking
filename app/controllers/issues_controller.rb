class IssuesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]

  def index

  end

  def show
    @issue = Issue.find(params[:id])
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = current_user.issues.build(issue_params)
    if @issue.save
      flash[:success] = "Issue created!"
      redirect_to @issue
    else
      flash[:danger] = @issue.errors.full_messages
      render 'new'
    end
  end

  private
  
    def issue_params
      params.require(:issue).permit(:name, :description)
    end

end
