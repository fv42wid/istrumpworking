class UpdatesController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_update, only: [:show, :edit, :update, :destroy]

  def show

  end

  def new
    @issue = Issue.find(params[:issue_id])
    @update = Update.new
  end

  def create
    @issue = Issue.find(params[:issue_id])
    @update = current_user.updates.build(update_params)
    @update.issue = @issue
    if @update.save
      flash[:success] = "Update created!"
      redirect_to issue_update_path(@issue,@update)
    else
      render 'new'
    end
  end

  private
  
    def get_update
      @update = Update.find(params[:id])
      @issue = Issue.find(params[:issue_id])
    end

    def update_params
      params.require(:update).permit(:name, :description, :citation, :score)
    end
end
