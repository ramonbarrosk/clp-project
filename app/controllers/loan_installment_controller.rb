class LoanInstallmentController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def create
    @service = ::LoanInstallment::Payment.call(
      api_params[:bank_loan_id],
      api_params[:value]
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
