class CreateFilm < ActiveRecord::Migration[7.0]
  def change
    create_table :film do |t|
      t.string :title
      t.integer :episode_id
      t.string :opening_crawl
      t.string :director
      t.string :producer
      t.datetime :release_date
      t.datetime :created
      t.datetime :edited
    end
    add_index :film, :episode_id
  end
end
