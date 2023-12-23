class Items::ItemCreateCommand
  include CommandModule
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :quantity, :integer
  attribute :category_id, :string
  attribute :user

  def run
    return false unless valid?

    user.items.create(name: name, quantity: quantity, category_id: category_id)
  end
end
