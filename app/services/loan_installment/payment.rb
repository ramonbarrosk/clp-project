class LoanInstallment::Payment
  prepend SimpleCommand

  def initialize(bank_loan_id, value)
    @bank_loan_id = bank_loan_id
    @value = value
  end

  def call
    bank_loan = BankLoan.find(@bank_loan_id)
    new_value = bank_loan.payment_amount - @value
    loan_installment = LoanInstallment.where(bank_loan_id: @bank_loan_id, status: false).order(created_at: :desc).last

    bank_loan.update(status: 'CONCLUÍDO!') if LoanInstallment.where(bank_loan_id: @bank_loan_id, status: false).empty?

    return 'O empréstimo já foi quitado!' if LoanInstallment.where(bank_loan_id: @bank_loan_id, status: false).empty?

    if @value >= loan_installment.value
      loan_installment.update(status: true)
      bank_loan.update(payment_amount: new_value)
      'Parcela paga com sucesso...'
    else
      'Valor insuficiente...'
    end
  end
end
