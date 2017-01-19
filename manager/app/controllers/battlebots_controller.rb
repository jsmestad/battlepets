class BattlebotsController < ApplicationController

  def index
    @battlebots = Battlebot.all
    render json: @battlebots
  end

  def create
    @battlebot = Battlebot.create(battlebot_params)

    if @battlebot.persisted?
      render json: @battlebot, status: :created
    else
      render json: {errors: @battlebot.errors.messages}, status: :bad_request
    end
  end

private

  def battlebot_params
    params.require(:battlebot).permit(:name, :user_id)
  end
end
