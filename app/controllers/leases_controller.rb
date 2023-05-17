class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find_by(id: params[:id])
        lease.destroy
        head :no_content
    end

  private
  
  def lease_params
    params.permit(:rent)
  end
  


  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
