class UpdatesController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]

  def new
    @issue = Issue.find(params[:issue_id])
    @update = Update.new
  end

  def create

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
