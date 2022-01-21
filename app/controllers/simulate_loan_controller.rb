class SimulateLoanController < ActionController::Base
  def index
    @service = SimulateLoan::Index.call(
      api_params[:loan_amount],
      api_params[:amount_of_installment]
    )

    if @service.success?
      render json: { data: @service.result }, status: 200
    else
      render json: { error: @service.errors }, status: 400
    end
  end

  private

  def api_params
    params.to_unsafe_h || {}
  end
end
