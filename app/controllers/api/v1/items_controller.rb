class Api::V1::ItemsController < BaseController
  before_action :authenticate_request

  def create
    item = Items::ItemCreateCommand.new(item_create_params).run

    if item.save
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    item = Items::ItemUpdateUseCase.new(item_update_params).run

    if item
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

  def item_create_params
    item_params = params.require(:item).permit(:name, :quantity)
    item_params.merge(category_id: params[:category_id], user: current_user)
  end

  def item_update_params
    item_params = params.require(:item).permit(:name, :quantity, :category_id)
    item_params.merge(item_id: params[:id], user: current_user)
  end
end
