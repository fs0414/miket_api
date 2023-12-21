class Api::V1::ItemsController < BaseController
  before_action :authenticate_request

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
    params.require(:item).permit(:name, :quantity, :category_id)
  end
end
