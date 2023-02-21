FactoryBot.define do
  factory :planet do
    name { FFaker::Name.unique.name }
    diameter { FFaker::PhoneNumber.area_code.to_s }
    rotation_period { FFaker::Number.number }
    orbital_period { FFaker::PhoneNumber.area_code.to_s }
    gravity { "1 standard" }
    population { "200000" }
    climate { "arid" }
    terrain { "desert" }
    surface_water { FFaker::Number.number }
  end
end