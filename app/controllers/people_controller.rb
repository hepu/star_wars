class PeopleController < AuthenticatedController
  before_action :find_person, only: %i[show update destroy]
  before_action :validate_planet, only: %i[create update]

  def index
    @people = Person.page(params[:page]).per(params[:per_page])
    
    meta = {
      current_page: @people.current_page,
      next_page: @people.next_page,
      prev_page: @people.prev_page,
      total_pages: @people.total_pages
    }

    render json: serialized_person(@people, { meta: meta })
  end

  def create
    @person = Person.new(person_params)
    @person.save!

    render json: serialized_person(@person), status: :created
  rescue StandardError => e
    Rails.logger.error("[PeopleController#create]: Error creating Person: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def show
    return head(:not_found) unless @person.present?

    render json: serialized_person(@person), status: :ok
  end

  def update
    @person.attributes = person_params
    @person.save!

    render json: serialized_person(@person), status: :ok
  rescue StandardError => e
    Rails.logger.error("[PeopleController#update]: Error updating Person: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def destroy
    return head(:not_found) unless @person.present?

    @person.destroy!

    head :no_content
  rescue StandardError => e
    Rails.logger.error("[PeopleController#destroy]: Error updating Person: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end
  
  private
  
  def person_params
    params.require(:person).permit(
      %i[
        birth_year
        created
        edited
        eye_color
        gender
        hair_color
        height
        mass
        name
        skin_color
        planet_id
      ]
    )
  end
  
  def find_person
    @person = Person.includes(:planet).find_by(id: params[:id])
  end
  
  def validate_planet
    return render(json: { error: 'Planet not found' }, status: :bad_request) unless Planet.exists?(person_params[:planet_id])
  end
  
  def serialized_person(person, options = {})

    PersonSerializer.new(person, { include: %i[planet] }.merge(options)).serialized_json
  end
end
