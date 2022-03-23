require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
    end

    context '商品購入ができる場合' do
      it '全ての入力項目を正しく入力していれば購入できる' do
        expect(@purchase_address).to be_valid
      end
      it 'buiding_nameが空でも購入できる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
    end

    context '商品購入ができない場合' do
      it 'tokenが空では購入できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "カード番号・有効期限・セキュリティコードを入力してください"
      end
      it 'post_codeが空では購入できない' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "郵便番号を入力してください"
      end
      it 'prefecture_idが1では購入できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "都道府県を選択してください"
      end
      it 'cityが空では購入できない' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "市区町村を入力してください"
      end
      it 'addressが空では購入できない' do
        @purchase_address.address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "番地以降を入力してください"
      end
      it 'phoneが空では購入できない' do
        @purchase_address.phone = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "電話番号を入力してください"
      end
      it 'post_codeにハイフンがなければ購入できない' do
        @purchase_address.post_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '郵便番号は例のように入力してください（例: 123-4567）'
      end
      it 'post_codeに3桁の数字と4桁の数字の間にハイフンがなければ購入できない' do
        @purchase_address.post_code = '12-45678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '郵便番号は例のように入力してください（例: 123-4567）'
      end
      it 'post_codeが全角数字では購入できない' do
        @purchase_address.post_code = '１２３−４５６７'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '郵便番号は例のように入力してください（例: 123-4567）'
      end
      it 'post_codeが全角英字では購入できない' do
        @purchase_address.post_code = 'ｇｋｌ-ｙｔｒｗ'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '郵便番号は例のように入力してください（例: 123-4567）'
      end
      it 'post_codeが半角英字では購入できない' do
        @purchase_address.post_code = 'asd-fghj'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '郵便番号は例のように入力してください（例: 123-4567）'
      end
      it 'phoneが全角数字では購入できない' do
        @purchase_address.phone = '０９０１２３４５６７'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '電話番号は半角数字のみで入力してください'
      end
      it 'phoneが全角英字では購入できない' do
        @purchase_address.phone = 'ｑｗｒｆｇｈｊｃｖｂ'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '電話番号は半角数字のみで入力してください'
      end
      it 'phoneが半角英字では購入できない' do
        @purchase_address.phone = 'abcdefghij'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '電話番号は半角数字のみで入力してください'
      end
      it 'phoneが10桁より少ないと購入できない' do
        @purchase_address.phone = '09012345'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '電話番号は10〜11桁で入力してください（ハイフンは不要）'
      end
      it 'phoneが12桁以上では購入できない' do
        @purchase_address.phone = '1234567891233'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '電話番号は10〜11桁で入力してください（ハイフンは不要）'
      end
      it 'itemと紐付いていなければ購入できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Itemを入力してください"
      end
      it 'userと紐付いていなければ購入できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Userを入力してください"
      end
    end
  end
end
