class Items::UserFindItemQuery
  include QueryModule
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :item_id, :string
  attribute :user

  def run
    item = user.items.find(item_id)

# binding.pry

  end
end
