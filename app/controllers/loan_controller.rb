class LoanController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def index
    @service = Loan::Index.call(
      api_params[:client_id]
    )

    if @service.success?
      render json: { data: @service.result }, status: 200
    else
      render json: { error: @service.errors }, status: 400
    end
  end

  def create
    @service = ::Loan::Create.call(
      api_params[:client_id],
      api_params[:bank_id],
      api_params[:type],
      api_params[:requested_amount],
      api_params[:total_installments]
    )

    if @service.success?
      render json: { data: @service.result }, status: 201
    else
      render json: { error: @service.errors }, status: 400
    end
  end

  private

  def api_params
    params.to_unsafe_h || {}
  end
end
