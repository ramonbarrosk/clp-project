class Loan::Index
  prepend SimpleCommand

  def initialize(client_id)
    @client_id = client_id
  end

  def call
    loans_client = BankLoan.joins(:loan_installment)
                           .where(client_id: @client_id)
                           .select("bank_loans.id,
                                    bank_id,
                                    loan_type,
                                    bank_loans.status AS status_bank_loan,
                                    requested_amount,
                                    payment_amount,
                                    interest_amount,
                                    total_installments,
                                    jsonb_agg(
                                      jsonb_build_object(
                                        'bank_loan_id', loan_installments.bank_loan_id,
                                        'value', ROUND(loan_installments.value :: DECIMAL, 2),
                                        'due_date', TO_CHAR(loan_installments.due_date :: DATE, 'Mon dd, yyyy'),
                                        'status_installment',loan_installments.status
                                      ) ORDER BY loan_installments.due_date
                                    ) AS loan_installments
                                    ")
                           .group('bank_loans.id',
                                  'requested_amount',
                                  'payment_amount',
                                  'interest_amount',
                                  'total_installments',
                                  'loan_type',
                                  'bank_id',
                                  'status_bank_loan')


    loans_client.map do |loan|
      {
        id: loan.id,
        bank_id: loan.bank_id,
        loan_type: loan.loan_type,
        status: loan.status_bank_loan,
        requested_amount: loan.requested_amount,
        payment_amount: loan.payment_amount,
        interest_amount: loan.interest_amount,
        total_installments: loan.total_installments,
        installments: loan.loan_installments
      }
    end
  end
end
