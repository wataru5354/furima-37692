class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name,                  null: false
      t.text       :explain,               null: false
      t.integer    :category_id,           null: false
      t.integer    :status_id,             null: false
      t.integer    :shipping_fee_id,       null: false
      t.integer    :scheduled_delivery_id, null: false
      t.integer    :prefecture_id,         null: false
      t.integer    :price,                 null: false
      t.timestamps
    end
  end
end
