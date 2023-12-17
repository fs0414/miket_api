class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :categories, dependent: :destroy
  has_many :items, dependent: :destroy


  enum :role, { user: 0, admin: 1 }

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 2 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end
