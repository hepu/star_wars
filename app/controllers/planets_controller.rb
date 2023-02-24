class PlanetsController < AuthenticatedController
  before_action :find_planet, only: %i[show update destroy]

  def index
    @planets = Planet.page(params[:page]).per(params[:per_page])
    meta = {
      current_page: @planets.current_page,
      next_page: @planets.next_page,
      prev_page: @planets.prev_page,
      total_pages: @planets.total_pages
    }

    render json: serialized_planet(@planets, { meta: meta })
  end

  def create
    @planet = Planet.new(planet_params)
    @planet.save!

    render json: serialized_planet(@planet), status: :created
  rescue StandardError => e
    Rails.logger.error("[PlanetsController#create]: Error creating Planet: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def show
    return head(:not_found) unless @planet.present?

    render json: serialized_planet(@planet), status: :ok
  end

  def update
    @planet.attributes = planet_params
    @planet.save!

    render json: serialized_planet(@planet), status: :ok
  rescue StandardError => e
    Rails.logger.error("[PlanetsController#update]: Error updating Planet: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def destroy
    return head(:not_found) unless @planet.present?

    @planet.destroy!

    head :no_content
  rescue StandardError => e
    Rails.logger.error("[PlanetsController#destroy]: Error updating Planet: #{e.message}")
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
  
  def serialized_planet(planet, options = {})
    PlanetSerializer.new(planet, options).serialized_json
  end
end
