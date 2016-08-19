class QuestsController < ApplicationController

  def show
    @quest = Quest.find(params[:id])
  end

  private

  def quest_params
    params.require(:quest).permit(:user_id, :name, :description, :state, :exp, :req_count)
  end


end
