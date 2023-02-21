FactoryBot.define do
  factory :person do
    name { FFaker::Name.unique.name }
    planet
  end
end