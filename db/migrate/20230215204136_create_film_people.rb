class CreateFilmPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :film_people do |t|
      t.integer :film_id
      t.integer :people_id
    end
    add_index :film_people, :film_id
    add_index :film_people, :people_id
  end
end
