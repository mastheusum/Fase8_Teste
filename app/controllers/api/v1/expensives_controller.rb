class Api::V1::ExpensivesController < ApplicationController
  before_action :authenticate_with_token!

  def index
    expensives = current_user.expensives
    render json: { expensives: expensives }, status: 200
  end

  def show
    expensive = current_user.expensives.find(params[:id])
    render json: expensive, status: 200
  end

  def create
    expensive = current_user.expensives.build(expensive_params)
    if expensive.save
      render json: expensive, status: 201
    else
      render json: { errors: expensive.errors }, status: 422
    end
  end
  
  def update
    expensive = current_user.expensives.find(params[:id])
    if expensive.update_attributes(expensive_params)
      render json: expensive, status: 200
    else
      render json: { errors: expensive.errors }, status: 422
    end
  end

  def destroy
    expensive = current_user.expensives.find(params[:id])
    expensive.destroy
    render json: {}, status: 204
  end

  private
    def expensive_params
      params.require(:expensive).permit(:description, :value, :date)
    end
end
