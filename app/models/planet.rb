class Planet < ApplicationRecord
  self.table_name = 'planet'
end

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
