class PlanetsController < ApplicationController
  before_action :find_planet, only: %i[show update destroy]

  def index
    @planets = Planet.all

    render json: @planets
  end

  def create
    @planet = Planet.new(planet_params)
    @planet.save!

    render json: @planet, status: :created
  rescue StandardError => e
    Rails.logger.error("[PlanetsController#create]: Error creating Planet: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def show
    return head(:not_found) unless @planet.present?

    render json: @planet, status: :ok
  end

  def update
    @planet.attributes = planet_params
    @planet.save!

    render json: @planet, status: :ok
  rescue StandardError => e
    Rails.logger.error("[PlanetsController#create]: Error updating Planet: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def destroy
    return head(:not_found) unless @planet.present?

    @planet.destroy!

    head :ok
  rescue StandardError => e
    Rails.logger.error("[PlanetsController#create]: Error updating Planet: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end
  
  private
  
  def planet_params
    params.require(:planet).permit(
      %i[
        climate
        created
        diameter
        edited
        gravity
        name
        orbital_period
        population
        rotation_period
        surface_water
        terrain
      ]
    )
  end
  
  def find_planet
    @planet = Planet.find_by(id: params[:id])
  end
end
