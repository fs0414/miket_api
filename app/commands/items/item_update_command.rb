class Items::ItemUpdateCommand
  include CommandModule
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :quantity, :integer
  attribute :category_id, :string
  attribute :item

  validates :name, presence: true
  validates :quantity, presence: true
  validates :category_id, presence: true

  def run
    item.update!(
      name: name,
      quantity: quantity,
      category_id: category_id
    )
    item
  end

  def success?
    errors.none?
  end
end
