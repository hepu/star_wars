FactoryBot.define do
  factory :user do
    email { FFaker::Internet.unique.email }
    username { FFaker::Internet.unique.user_name }
    password { '123456' }
    password_confirmation { '123456' }
  end
end