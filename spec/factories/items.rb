FactoryBot.define do
  factory :item do
    name     { Faker::Lorem.words }
    explain  { Faker::Lorem.sentences }
    category { Category.where.not(name: '---').sample }
    status   { Status.where.not(name: '---').sample }
    shipping_fee { ShippingFee.where.not(name: '---').sample }
    scheduled_delivery { ScheduledDelivery.where.not(name: '---').sample }
    prefecture { Prefecture.find 34 }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
