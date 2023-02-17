class FilmsController < ApplicationController
  before_action :find_film, only: %i[show update destroy]

  def index
    @films = Film.all

    render json: serialized_film(@films)
  end

  def create
    @film = Film.new(film_params)
    @film.save!

    render json: serialized_film(@film), status: :created
  rescue StandardError => e
    Rails.logger.error("[FilmsController#create]: Error creating Film: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def show
    return head(:not_found) unless @film.present?

    render json: serialized_film(@film), status: :ok
  end

  def update
    @film.attributes = film_params
    @film.save!

    render json: serialized_film(@film), status: :ok
  rescue StandardError => e
    Rails.logger.error("[FilmsController#update]: Error updating Film: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def destroy
    return head(:not_found) unless @film.present?

    @film.destroy!

    head :no_content
  rescue StandardError => e
    Rails.logger.error("[FilmsController#destroy]: Error updating Film: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end
  
  private
  
  def film_params
    params.require(:film).permit(
      %i[
        created
        director
        edited
        opening_crawl
        producer
        release_date
        title
        episode_id
      ]
    )
  end
  
  def find_film
    @film = Film.find_by(id: params[:id])
  end
  
  def serialized_film(film)
    FilmSerializer.new(film).serialized_json
  end
end
