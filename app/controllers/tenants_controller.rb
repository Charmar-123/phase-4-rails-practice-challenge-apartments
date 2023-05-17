class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find_by(id: params[:id])
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = Tenant.find_by(id: params[:id])
        tenant.update(tenant_params_update)
        render json: tenant, status: :accepted
    end

    def destroy
        tenant = Tenant.find_by(id: params[:id])
        tenant.destroy
        head :no_content
    end

  private
  
  def tenant_params
    params.permit(:name, :age)
  end
  
  def tenant_params_update
    params.permit(:name, :age)
end

  def render_not_found_response
    render json: { error: "Tenant not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
