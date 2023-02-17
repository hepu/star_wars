class FilmPeopleController < ApplicationController
  before_action :find_film_person, only: %i[show update destroy]
  before_action :validate_film, only: %i[create update]
  before_action :validate_person, only: %i[create update]

  def index
    @film_people = FilmPerson.includes(:person, :film)

    render json: serialized_film_person(@film_people)
  end

  def create
    @film_person = FilmPerson.new(film_people_params)
    @film_person.save!

    render json: serialized_film_person(@film_person), status: :created
  rescue StandardError => e
    Rails.logger.error("[FilmPeopleController#create]: Error creating FilmPerson: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def show
    return head(:not_found) unless @film_person.present?

    render json: serialized_film_person(@film_person), status: :ok
  end

  def update
    @film_person.attributes = film_people_params
    @film_person.save!

    render json: serialized_film_person(@film_person), status: :ok
  rescue StandardError => e
    Rails.logger.error("[FilmPeopleController#update]: Error updating FilmPerson: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end

  def destroy
    return head(:not_found) unless @film_person.present?

    @film_person.destroy!

    head :no_content
  rescue StandardError => e
    Rails.logger.error("[FilmPeopleController#destroy]: Error updating FilmPerson: #{e.message}")
    render json: { error: e.message }, status: :bad_request
  end
  
  private
  
  def film_people_params
    params.require(:film_people).permit(
      %i[
        film_id
        people_id
      ]
    )
  end
  
  def find_film_person
    @film_person = FilmPerson.find_by(id: params[:id]).includes(:film, :person)
  end
  
  def validate_film
    return render(json: { error: 'Film not found' }, status: :bad_request) unless Film.exists?(id: film_people_params[:film_id])
  end
  
  def validate_person
    return render(json: { error: 'Film not found' }, status: :bad_request) unless Film.exists?(id: film_people_params[:film_id])
  end
  
  def serialized_film_person(film_person)
    FilmPersonSerializer.new(film_person, include: %i[film people]).serialized_json
  end
end
