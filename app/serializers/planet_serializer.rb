class PlanetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :climate, :created, :diameter, :edited, :gravity, :name, :orbital_period, :population, :rotation_period, :surface_water, :terrain
  has_many :film_planets
end