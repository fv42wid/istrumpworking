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
      render 'new'
    end
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    if @issue.update_attributes(issue_params)
      flash[:success] = "Issue updated!"
      redirect_to @issue
    else
      render 'edit'
    end
  end

  private
  
    def issue_params
      params.require(:issue).permit(:name, :description)
    end

end
