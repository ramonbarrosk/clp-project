class LoanController < ActionController::Base
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

  private

  def api_params
    params.to_unsafe_h || {}
  end
end
