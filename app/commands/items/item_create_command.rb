class Items::ItemCreateCommand
  include CommandModule
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :quantity, :integer
  attribute :category_id, :string
  attribute :user

  validates :name, presence: true

  def run
    return false unless valid?

    user.items.new(name: name, quantity: quantity, category_id: category_id)
  end
end
