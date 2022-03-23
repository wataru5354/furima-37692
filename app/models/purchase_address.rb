class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :phone, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は例のように入力してください（例: 123-4567）' }
    validates :city
    validates :address
    validates :phone, length: { in: 10..11, message: 'は10〜11桁で入力してください（ハイフンは不要）' },
                      format: { with: /\A[0-9]+\z/, message: 'は半角数字のみで入力してください' }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
                   building_name: building_name, phone: phone, purchase_id: purchase.id)
  end
end
