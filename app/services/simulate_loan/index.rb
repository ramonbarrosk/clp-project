class SimulateLoan::Index
  prepend SimpleCommand

  def initialize(requested_amount, total_installment)
    @loan_amount = requested_amount.to_f
    @amount_of_installment = total_installment.to_i
    @interest_per_month = 4.2 / 100
  end

  def call
    interest_value = @loan_amount * @interest_per_month * @amount_of_installment
    total_payable = @loan_amount + interest_value

    installment_value = total_payable / @amount_of_installment

    {
      loan_amount: @loan_amount,
      total_payable: total_payable,
      installment_value: installment_value,
      amount_of_installment: @amount_of_installment
    }
  end
end
