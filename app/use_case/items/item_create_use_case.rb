class Items::ItemCreateUseCase
  include UseCase
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :quantity, :integer
  attribute :category_id, :integer
  attribute :user
end
