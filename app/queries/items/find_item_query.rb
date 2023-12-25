class Items::FindItemQuery
  include QueryModule
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :item_id, :string

  def run
    Item.where(id: item_id)
  end
end
