# == Schema Information
#
# Table name: film
#
#  id            :integer          not null, primary key
#  created       :datetime
#  director      :string
#  edited        :datetime
#  opening_crawl :string
#  producer      :string
#  release_date  :datetime
#  title         :string
#  episode_id    :integer
#
# Indexes
#
#  index_film_on_episode_id  (episode_id)
#
FactoryBot.define do
  factory :film do
    title { FFaker::Movie.unique.title }
  end
end
