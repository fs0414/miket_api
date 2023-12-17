class Api::V1::UsersController < BaseController
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

    render json: { token: token, user: user }, status: :ok
    rescue => e
      render json: { error: e }, status: :unauthorized
  end

  def signout
    logout
    render json: { message: 'logout success' }
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end

  def form_authenticity_token; end
end
