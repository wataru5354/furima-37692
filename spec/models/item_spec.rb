require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できる場合' do
      it '全ての入力項目を正しく入力していれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
      it 'explainが空では出品できない' do
        @item.explain = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Explain can't be blank"
      end
      it 'category_idが1では出品できない' do
        @item.category = Category.find 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it 'status_idが1では出品できない' do
        @item.status = Status.find 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Status can't be blank"
      end
      it 'shipping_fee_idが1では出品できない' do
        @item.shipping_fee = ShippingFee.find 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee can't be blank"
      end
      it 'prefecture_idが1では出品できない' do
        @item.prefecture = Prefecture.find 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'scheduled_delivery_idが1では出品できない' do
        @item.scheduled_delivery = ScheduledDelivery.find 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Scheduled delivery can't be blank"
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it 'priceで入力した値が300より小さい値では出品できない' do
        @item.price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is out of setting range'
      end
      it 'priceで入力した値が9,999,999より大きい値では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is out of setting range'
      end
      it 'priceが全角英字では出品されない' do
        @item.price = 'ｓｋｙｐ'
        @item.invalid?
        expect(@item.errors.full_messages).to include 'Price is invalid. Input half-width numbers'
      end
      it 'priceが全角数字では出品できない' do
        @item.price = '１１１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is invalid. Input half-width numbers'
      end
      it 'priceが半角英字では出品できない' do
        @item.price = 'asdfg'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is invalid. Input half-width numbers'
      end
      it 'priceが半角英数字混合では出品できない' do
        @item.price = '1as3d'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is invalid. Input half-width numbers'
      end
      it 'userが紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end
    end
  end
end
