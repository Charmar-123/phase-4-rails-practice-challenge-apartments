class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
        appartments = Apartment.all
        render json: appartments
    end

    def show
        appartment = Apartment.find_by(id: params[:id])
        render json: appartment
    end

    def create
        appartment = Apartment.create!(appartment_params)
        render json: appartment, status: :created
    end

    def update
        appartment = Apartment.find_by(id: params[:id])
        appartment.update(appartment_params_update)
        render json: appartment, status: :accepted
    end

    def destroy
        appartment = Apartment.find_by(id: params[:id])
        appartment.destroy
        head :no_content
    end

  private
  
  def appartment_params
    params.permit(:number)
  end
  
  def appartment_params_update
    params.permit(:number)
end

  def render_not_found_response
    render json: { error: "Appartment not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
