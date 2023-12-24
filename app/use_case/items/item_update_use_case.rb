class Items::ItemUpdateUseCase
  include UseCaseModule
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :quantity, :integer
  attribute :category_id, :string
  attribute :item_id, :string
  attribute :user

  def run
    use_case = ApplicationRecord.transaction do
      find_item = Items::UserFindItemQuery.new(user: user, item_id: item_id).run

      updated_item = Items::ItemUpdateCommand.new(name: name, quantity: quantity, category_id: category_id, user: user, item: find_item).run
      updated_item
    end

    use_case
  end
end
