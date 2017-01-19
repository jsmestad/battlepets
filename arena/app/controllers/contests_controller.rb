class ContestsController < ApplicationController

  def index
    @contests = Contest.all
    render json: @contests
  end

  def create
    @contest = Contest.create(contest_params)

    if @contest.persisted?
      render json: @contest, status: :created
    else
      render json: {errors: @contest.errors.messages}, status: :bad_request
    end
  end

private

  def contest_params
    params.require(:contest).permit(defendant: [:id, :name], challenger: [:id, :name])
  end

end
