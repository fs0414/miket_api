class ItemCreateForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :quantity, :integer
  attribute :category_id, :integer
  attribute :user

  def call
    return false unless valid?

    user.items.create(name: name, quantity: quantity, category_id: category_id)
  end
end
