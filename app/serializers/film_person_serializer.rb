class FilmPersonSerializer
  include FastJsonapi::ObjectSerializer

  attributes :film_id, :people_id
  belongs_to :film
  belongs_to :people, record_type: :person
end