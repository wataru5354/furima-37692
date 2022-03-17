class Item < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :name
    validates :explain
  end

  validates :price, presence: true, numericality: { only_integer: true, message: 'is invalid. Input half-width numbers' },
                    inclusion: { in: 300..9_999_999, message: 'is out of setting range' }
  belongs_to :user
  # has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :scheduled_delivery
  belongs_to :prefecture

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :scheduled_delivery_id
    validates :prefecture_id
  end
end
