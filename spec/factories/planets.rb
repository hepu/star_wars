# == Schema Information
#
# Table name: planet
#
#  id              :integer          not null, primary key
#  climate         :string
#  created         :datetime
#  diameter        :string
#  edited          :datetime
#  gravity         :string
#  name            :string
#  orbital_period  :string
#  population      :string
#  rotation_period :string
#  surface_water   :string
#  terrain         :string
#
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
