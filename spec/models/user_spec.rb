require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができる場合' do
      it '全ての入力項目を正しく入力すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名字を入力してください"
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前を入力してください"
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名字（カナ）を入力してください"
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前（カナ）を入力してください"
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "誕生日を入力してください"
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'as123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは128文字以内で入力してください'
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'as1234'
        @user.password_confirmation = 'az2345'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Eメールはすでに存在します'
      end
      it 'emailに@がないと登録できない' do
        @user.email = 'testsample'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールは不正な値です'
      end
      it 'passwordが全角では登録できない' do
        @user.password = 'ｋｄｔｒｗｑｇ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは半角英字と半角数字を含めて入力してください'
      end
      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'abcdefg'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは半角英字と半角数字を含めて入力してください'
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは半角英字と半角数字を含めて入力してください'
      end
      it 'last_nameが半角では登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include '名字は全角で入力してください'
      end
      it 'first_nameが半角では登録できない' do
        @user.first_name = 'hiroto'
        @user.valid?
        expect(@user.errors.full_messages).to include '名前は全角で入力してください'
      end
      it 'last_name_kanaが半角では登録できない' do
        @user.last_name_kana = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include '名字（カナ）は全角のカタカナで入力してください'
      end
      it 'first_name_kanaが半角では登録できない' do
        @user.first_name_kana = 'kaori'
        @user.valid?
        expect(@user.errors.full_messages).to include '名前（カナ）は全角のカタカナで入力してください'
      end
      it 'last_name_kanaが全角の漢字では登録できない' do
        @user.last_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include '名字（カナ）は全角のカタカナで入力してください'
      end
      it 'first_name_kanaが全角の漢字では登録できない' do
        @user.first_name_kana = '弘樹'
        @user.valid?
        expect(@user.errors.full_messages).to include '名前（カナ）は全角のカタカナで入力してください'
      end
      it 'last_name_kanaが全角のひらがなでは登録できない' do
        @user.last_name_kana = Gimei.name.last.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include '名字（カナ）は全角のカタカナで入力してください'
      end
      it 'first_name_kanaが全角のひらがなでは登録できない' do
        @user.first_name_kana = Gimei.name.first.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include '名前（カナ）は全角のカタカナで入力してください'
      end
    end
  end
end
