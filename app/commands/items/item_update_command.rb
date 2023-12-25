class Items::ItemUpdateCommand
  include CommandModule
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :quantity, :integer
  attribute :category_id, :string
  attribute :item

  def run
    item.update(name: name, quantity: quantity, category_id: category_id)

    updated_item = item
    updated_item
  end
end
