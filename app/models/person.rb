class Person < ApplicationRecord
  belongs_to :planet
  
  paginates_per 50
end

# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  birth_year :string
#  created    :datetime
#  edited     :datetime
#  eye_color  :string
#  gender     :string
#  hair_color :string
#  height     :string
#  mass       :string
#  name       :string
#  skin_color :string
#  planet_id  :integer
#
# Indexes
#
#  index_people_on_planet_id  (planet_id)
#
