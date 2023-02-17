class FilmPlanetsController < ApplicationController
  before_action :find_film_planet, only: %i[show update destroy]
  before_action :validate_film_and_planet, only: %i[create update]

  def index
    @film_planets = FilmPlanet.all

    render json: @film_planets
  end

  def create
    @film_planet = FilmPlanet.new(film_planet_params)
    @film_planet.save!

    render json: @film_planet, status: :created
  rescue StandardError => e
    Rails.logger.error("[FilmPlanetsController#create]: Error creating FilmPlanet: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def show
    return head(:not_found) unless @film_planet.present?

    render json: @film_planet, status: :ok
  end

  def update
    @film_planet.attributes = film_planet_params
    @film_planet.save!

    render json: @film_planet, status: :ok
  rescue StandardError => e
    Rails.logger.error("[FilmPlanetsController#update]: Error updating FilmPlanet: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def destroy
    return head(:not_found) unless @film_planet.present?

    @film_planet.destroy!

    head :no_content
  rescue StandardError => e
    Rails.logger.error("[FilmPlanetsController#destroy]: Error updating FilmPlanet: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end
  
  private
  
  def film_planet_params
    params.require(:film_planet).permit(
      %i[
        film_id
        planet_id
      ]
    )
  end
  
  def find_film_planet
    @film_planet = FilmPlanet.find_by(id: params[:id])
  end
  
  def validate_film_and_planet
    return render(json: { error: 'Film not found' }, status: :bad_request) unless Film.exists?(id: film_planet_params[:film_id])
    return render(json: { error: 'Planet not found' }, status: :bad_request) unless Planet.exists?(id: film_planet_params[:planet_id])
  end
end
