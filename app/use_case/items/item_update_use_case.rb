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
    command = ApplicationRecord.transaction do
      find_item = Items::FindItemQuery.new(item_id: item_id).run

      Items::ItemUpdateCommand.new(
        name: name,
        quantity: quantity,
        category_id: category_id,
        item: find_item
      ).run
    end

    return command if command
  end
end
