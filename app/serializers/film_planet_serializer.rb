class FilmPlanetSerializer
  include FastJsonapi::ObjectSerializer

  attributes :film_id, :planet_id
  belongs_to :film
  belongs_to :planet
end