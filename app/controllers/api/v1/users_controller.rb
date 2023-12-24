class Api::V1::UsersController < BaseController
  before_action :authenticate_request, except: [:signup, :signin]
  def index
    users = User.all
    render json: { data: users }
  end

  def signup
    user = User.new(user_params)

    if user.save
      category = Category.create(
        [
          {
            name: "goods",
            user_id: user.id
          },
          {
            name: "furniture",
            user_id: user.id
          },
          {
            name: "fashion",
            user_id: user.id
          }
        ]
      )
      render json: { user: user, categpry: category }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def signin


    user = login(params[:email], params[:password])

    jwt_secret = ENV['JWT_SECRET']

    token = JWT.encode({ email: user.email }, jwt_secret)

    render json: { token: token, user: user.as_json(only: [:id, :name, :email, :role]) }, status: :ok
    rescue => e
      render json: { error: e }, status: :unauthorized
  end

  def signout
    logout
    render json: { message: 'logout success' }
  end

  def update_max_items
    item = current_user.update(max_items: max_items_params[:max_items])
    render json: item
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end

  def max_items_params
    params.permit(:max_items)
  end

  def form_authenticity_token; end
end
