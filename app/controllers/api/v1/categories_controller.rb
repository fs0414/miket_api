class Api::V1::CategoriesController < BaseController
  before_action :authenticate_request

  def index
    categories = current_user.categories.as_json(include: :items)
    render json: categories
  end
end
