class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :phone, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it has follows (e.g. 123-4567)' }
    validates :city
    validates :address
    validates :phone, length: { in:10..11, message: 'number is too short' },
                      format: { with: /\A[0-9]+\z/, message: 'number is invalid. Input only number' }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
                   building_name: building_name, phone: phone, purchase_id: purchase.id)
  end
end
