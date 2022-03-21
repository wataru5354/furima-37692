FactoryBot.define do
  factory :purchase_address do
    post_code { '123-4567' }
    prefecture_id { 24 }
    city { '渋谷区' }
    address { '11-1' }
    building_name { '青山ビル403号室' }
    phone { '0901234567' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
