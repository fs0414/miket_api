class Items::ItemCreateCommand
  include CommandModule
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :quantity, :integer
  attribute :category_id, :string
  attribute :user

  validates :name, presence: true
  validates :quantity, presence: true

  def run
    user.items.create!(name: name, quantity: quantity, category_id: category_id)
  end
end
