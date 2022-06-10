class CampersController < ApplicationController
  
  def index
    campers = Camper.all
    render json: campers.to_json(only: [:id, :name, :age]), status: :ok
  end

  def show
    camper = Camper.find_by(id: params[:id])
    if camper 
      render json: camper, status: :ok
    else
      render json: {error: "Camper not found"}, status: :not_found
    end
  end

  def create
    new_camper = Camper.create!(camper_params)
    render json: new_camper, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def camper_params
    params.permit(:name, :age)
  end

end
