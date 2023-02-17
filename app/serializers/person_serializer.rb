class PersonSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :birth_year,
             :created,
             :edited,
             :eye_color,
             :gender,
             :hair_color,
             :height,
             :mass,
             :name,
             :skin_color,
             :planet_id
  belongs_to :planet
end