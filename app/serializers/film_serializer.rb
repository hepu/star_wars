class FilmSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :created, :director, :edited, :opening_crawl, :producer, :release_date, :title, :episode_id
  has_many :film_planets
end