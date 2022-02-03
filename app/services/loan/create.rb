class Loan::Create
  prepend SimpleCommand

  def initialize(client_id, bank_id, type, requested_amount, total_installments)
    @client_id = client_id
    @bank_id = bank_id
    @type = type
    @requested_amount = requested_amount
    @total_installments = total_installments.to_i
    @interest_per_month = 4.2 / 100
  end

  def call
    interest_value = @requested_amount * @interest_per_month * @total_installments
    total_payable = @requested_amount + interest_value
    installment_value = total_payable / @total_installments

    bank_loan = BankLoan.new
    bank_loan.client_id = @client_id
    bank_loan.bank_id = @bank_id
    bank_loan.type = @type
    bank_loan.requested_amount = @requested_amount
    bank_loan.total_installments = @total_installments
    bank_loan.payment_amount = total_payable
    bank_loan.status = "EM ANDAMENTO"

    bank_loan.save

    for i in 1..@total_installments
      loan_installment = LoanInstallment.new
      loan_installment.value = installment_value
      loan_installment.status = "PENDENTE"
      loan_installment.bank_loan_id = bank_loan.id
      loan_installment.save
    end
  end
end
