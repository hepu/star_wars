class CreateFilmPlanet < ActiveRecord::Migration[7.0]
  def change
    create_table :film_planet do |t|
      t.integer :film_id
      t.integer :planet_id
    end
    add_index :film_planet, :film_id
    add_index :film_planet, :planet_id
  end
end
