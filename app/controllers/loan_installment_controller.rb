class LoanInstallmentController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def update
    @service = ::LoanInstallment::Update.call(
      set_bank_loan,
      api_params[:value]
    )

    if @service.success?
      render json: { data: @service.result }, status: 201
    else
      render json: { error: @service.errors }, status: 400
    end
  end

  private

  def set_bank_loan
    BankLoan.find_by(id: api_params[:id], status: 'EM ANDAMENTO')
  end

  def api_params
    params.to_unsafe_h || {}
  end
end
