class Api::V1::CategoriesController < BaseController
  before_action :authenticate_request

  def index
    if params[:search]
      search = params[:search].to_s
      @categories = current_user.categories.where(
        # 'name LIKE ?', "#{search}"
        'name LIKE ?', "%#{search}%"
      ).as_json(include: :items)

    else
      @categories = current_user.categories.as_json(include: :items)
    end

    items = current_user.items
    quantities = items.map(&:quantity)
    total_items = quantities.sum
    ExampleJob.perform_later

    max_items = current_user.max_items
    render json: { categories: @categories, total_items: total_items, max_items: max_items }
  end
end
