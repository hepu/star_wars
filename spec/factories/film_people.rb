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
FactoryBot.define do
  factory :film_person do
    film
    person
  end
end
