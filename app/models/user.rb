class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers' }
  VALID_NAME_WIDTH_REGEX = /\A[ぁ-んァ-ヶー-龥々ー]+\z/.freeze
  validates :last_name, presence: true,
                        format: { with: VALID_NAME_WIDTH_REGEX, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: true,
                         format: { with: VALID_NAME_WIDTH_REGEX, message: 'is invalid. Input full-width characters' }
  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  validates :last_name_kana, presence: true,
                             format: { with: VALID_NAME_KANA_REGEX, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, presence: true,
                              format: { with: VALID_NAME_KANA_REGEX, message: 'is invalid. Input full-width katakana characters' }
  validates :birthday, presence: true
end
