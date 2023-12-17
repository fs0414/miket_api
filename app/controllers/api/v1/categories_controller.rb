class Api::V1::CategoriesController < BaseController
  before_action :require_login

  def index
    categories = current_user.categories.as_json(include: :items)
    render json: { user_id: current_user.id, data: categories }
  end
end
