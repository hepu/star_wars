class FilmPerson < ApplicationRecord
  belongs_to :film
  belongs_to :person, foreign_key: :people_id
  
  def people
    self.person
  end
  
  def person_id
    self.people_id
  end
end

# == Schema Information
#
# Table name: film_people
#
#  id        :integer          not null, primary key
#  film_id   :integer
#  people_id :integer
#
# Indexes
#
#  index_film_people_on_film_id    (film_id)
#  index_film_people_on_people_id  (people_id)
#
