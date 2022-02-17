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
    return 'Você não possui esse limite de empréstimo! (Até R$ 2000,00)' if @requested_amount > 2000
    return 'Você ainda possui empréstimo pendente!' if BankLoan.find_by(client_id: @client_id, status: 'EM ANDAMENTO')

    interest_value = @requested_amount * @interest_per_month * @total_installments
    total_payable = @requested_amount + interest_value
    installment_value = total_payable / @total_installments

    bank_loan = BankLoan.new
    bank_loan.client_id = @client_id
    bank_loan.bank_id = @bank_id
    bank_loan.loan_type = @type
    bank_loan.interest_amount = interest_value
    bank_loan.requested_amount = @requested_amount
    bank_loan.total_installments = @total_installments
    bank_loan.payment_amount = total_payable
    bank_loan.status = "EM ANDAMENTO"

    bank_loan.save

    date_current = Date.today

    for i in 1..@total_installments
      due_date = date_current + 30.days
      date_current = due_date
      loan_installment = LoanInstallment.new
      loan_installment.value = installment_value
      loan_installment.status = "PENDENTE"
      loan_installment.due_date = due_date
      loan_installment.status = false
      loan_installment.bank_loan_id = bank_loan.id
      loan_installment.save
    end
  end
end
