class Api::V1::CategoriesController < BaseController
  before_action :require_login

  def index
    categories = Category.where(user_id: params[:user_id])
    render json: categories
  end
end
