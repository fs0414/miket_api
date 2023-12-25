class Api::V1::CategoriesController < BaseController
  before_action :authenticate_request

  def index
    categories = current_user.categories.as_json(include: :items)
    items = current_user.items
    quantities = items.map(&:quantity)
    total_items = quantities.sum

    max_items = current_user.max_items
    render json: { categories: categories, total_items: total_items, max_items: max_items }
  end
end
