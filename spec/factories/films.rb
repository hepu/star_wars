FactoryBot.define do
  factory :film do
    title { FFaker::Movie.unique.title }
  end
end