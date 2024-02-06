class Api::V1::ItemsController < BaseController
  before_action :authenticate_request

  def create
    name, quantity, category_id = item_create_params.values_at(:name, :quantity, :category_id)
    item = Items::ItemCreateCommand.new(
      name: name,
      quantity: quantity,
      category_id: category_id,
      user: current_user
    ).run

    render json: item
  end

  def update
    item = Items::ItemUpdateUseCase.new(item_update_params).run

    render json: item
  end

  def destroy
    item = current_user.items.find(params[:id])

    item.destroy!
    # if item.destroy
    #   render json: item
    # else
    #   render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    # end
  end

  private

  def item_create_params
    item_params = params.require(:item).permit(:name, :quantity)
    item_params.merge(category_id: params[:category_id])
  end

  def item_update_params
    item_params = params.require(:item).permit(:name, :quantity, :category_id)
    item_params.merge(item_id: params[:id], user: current_user)
  end

end
