class Api::V1::ItemsController < ApplicationController
  before_action :require_login

  def create
    item = current_user.items.new(item_params)
    item.category_id = params[:category_id]

    if item.save
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    item = current_user.items.find(params[:id])

    if item.update(item_params)
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    item = current_user.items.find(params[:id])

    if item.destroy
      render json: { message: 'Item successfully deleted.' }
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :quantity)
  end
end
