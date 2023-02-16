class CreatePlanet < ActiveRecord::Migration[7.0]
  def change
    create_table :planet do |t|
      t.string :name
      t.string :diameter
      t.string :rotation_period
      t.string :orbital_period
      t.string :gravity
      t.string :population
      t.string :climate
      t.string :terrain
      t.string :surface_water
      t.datetime :created
      t.datetime :edited
    end
  end
end
