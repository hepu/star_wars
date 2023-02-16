class FilmPlanet < ApplicationRecord
  self.table_name = 'film_planet'
  
  belongs_to :film
  belongs_to :planet
end

# == Schema Information
#
# Table name: film_planet
#
#  id        :integer          not null, primary key
#  film_id   :integer
#  planet_id :integer
#
# Indexes
#
#  index_film_planet_on_film_id    (film_id)
#  index_film_planet_on_planet_id  (planet_id)
#
